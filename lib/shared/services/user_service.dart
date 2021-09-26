import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

class UserService {
  var basedUri = 'http://10.0.2.2:8080/api/user';

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${currentUser.token}',
  };

  Future<LatLng> getCurrentCoordinates() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  Future<String> getCurrentLocation() async {
    await getAddressByUserId();

    if (userAddress.isNotEmpty) {
      Address? address =
          userAddress.firstWhereOrNull((addr) => addr.isDeliveryAddress == 'Y');
      if (address != null) {
        return address.location;
      }
    }
    LatLng latLng = await getCurrentCoordinates();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    String? street = placemarks[0].street;
    String? name = placemarks[0].name;
    String? subLocality = placemarks[0].subLocality;
    String? province = placemarks[0].administrativeArea;
    String? postalCode = placemarks[0].postalCode;
    String? country = placemarks[0].country;

    return '${street}, ${name}, ${subLocality}, ${province}, ${postalCode}, ${country}';
  }

  Future<bool> addNewAddress({
    required String name,
    required String location,
    required String note,
    required LatLng coordinate,
  }) async {
    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/address/user/${currentUser.id}'),
      headers: requestHeaders,
      body: jsonEncode({
        'name': name,
        'address': location,
        'additionalNote': note,
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
        'isDeliveryAddress': 'N',
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }

  Future<bool> updateAddressById(
      {required int id,
      required String name,
      required String location,
      required String note,
      required LatLng coordinate,
      required String isDeliveryAddress}) async {
    // Call Api
    var response = await http.put(
      Uri.parse('${basedUri}/address/${id}'),
      headers: requestHeaders,
      body: jsonEncode({
        'name': name,
        'address': location,
        'additionalNote': note,
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
        'isDeliveryAddress': isDeliveryAddress,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }

  Future<void> getAddressByUserId() async {
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/address/user/${currentUser.id}'),
      headers: requestHeaders,
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      userAddress =
          body['data'].map<Address>((json) => Address.fromJson(json)).toList();
    }
  }

  Future<void> updateShippingAddressStatus({
    required int addressId,
    required bool isShippingAddress,
  }) async {
    // Call Api
    var response = await http.patch(
      Uri.parse('${basedUri}/address/${addressId}'),
      headers: requestHeaders,
      body: jsonEncode({
        'userId': currentUser.id,
        'isDeliveryAddress': isShippingAddress ? 'Y' : 'N',
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      userAddress.firstWhere((addr) => addr.id == addressId).isDeliveryAddress =
          isShippingAddress ? 'Y' : 'N';
    }
  }

  Future<bool> updatePersonalInfo() async {
    // Call Api
    bool isAllergyAdded = await addDrugAllergy();
    bool isDiseaseAdded = await addCongenitalDisease();

    var response = await http.put(
      Uri.parse('$basedUri/profile/${currentUser.id}'),
      headers: requestHeaders,
      body: jsonEncode({
        'title': tempUser.title,
        'firstname': tempUser.firstname,
        'lastname': tempUser.lastname,
        'dob': tempUser.dob,
        'gender': tempUser.gender,
        'height': tempUser.height,
        'weight': tempUser.weight,
        'phone': tempUser.phone,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 &&
        response.statusCode < 205 &&
        isAllergyAdded &&
        isDiseaseAdded) {
      // Convert response body to UserDetail object
      Map<String, dynamic> body = jsonDecode(response.body);
      // Reserve jwt token
      String jwtToken = currentUser.token;
      currentUser = UserDetail.fromJson(body['data']);
      currentUser.token = jwtToken;

      // Reset user info when sign up
      tempUser = new UserDetail(
        id: 0,
        email: '',
        password: '',
        title: 'Mr.',
        firstname: '',
        lastname: '',
        gender: 'M',
        height: 0,
        weight: 0,
        phone: '',
        dob: '',
        drugAllergy: [],
        congenitalDisease: [],
        image: '',
      );

      return true;
    }
    return false;
  }

  Future<bool> addDrugAllergy() async {
    if (tempUser.drugAllergy.length > 0) {
      for (int i = 0; i < tempUser.drugAllergy.length; i++) {
        var obj = {
          'name': tempUser.drugAllergy[i].name!,
          'reaction': tempUser.drugAllergy[i].reaction!,
          'severity': tempUser.drugAllergy[i].severity!,
        };

        // Call Api
        var response = await http.post(
          Uri.parse('$basedUri/drug-allergy/user/${currentUser.id}'),
          headers: requestHeaders,
          body: jsonEncode(obj),
        );

        // Handle response
        if (response.statusCode >= 300) {
          return false;
        }
      }
    }
    return true;
  }

  Future<bool> addCongenitalDisease() async {
    if (tempUser.congenitalDisease.length > 0) {
      for (int i = 0; i < tempUser.congenitalDisease.length; i++) {
        var obj = {
          'name': tempUser.congenitalDisease[i].name!,
          'reaction': tempUser.congenitalDisease[i].reaction!,
          'severity': tempUser.congenitalDisease[i].severity!,
        };

        // Call Api
        var response = await http.post(
          Uri.parse('$basedUri/congenital-disease/user/${currentUser.id}'),
          headers: requestHeaders,
          body: jsonEncode(obj),
        );

        // Handle response
        if (response.statusCode >= 300) {
          return false;
        }
      }
    }
    return true;
  }

  Future<bool> updateProfileImage(File imageFile) async {
    // Prepare image file
    var uri = Uri.parse('${basedUri}/profile/${currentUser.id}/image');
    var request = new http.MultipartRequest("PATCH", uri);
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    request.files.add(
      http.MultipartFile(
        'image',
        stream,
        length,
        filename: '${currentUser.id}${currentUser.firstname}',
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(requestHeaders);

    // Call Api
    var response = await request.send();

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      String profileImage = await getProfileImage(currentUser.id);
      if (profileImage != '') return true;
    }
    return false;
  }

  Future<String> getProfileImage(int userId) async {
    var response = await http.get(
      Uri.parse('${basedUri}/profile/${userId}/image'),
      headers: requestHeaders,
    );
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      currentUser.image = body['data']['Psn_Image'];
      return body['data']['Psn_Image'];
    }
    return '';
  }

  Future<UserDetail?> getUserById(int userId) async {
    var response = await http.get(
      Uri.parse('${basedUri}/profile/${userId}'),
      headers: requestHeaders,
    );

    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      UserDetail user = UserDetail.fromJson(body['data']);
      return user;
    }
    return null;
  }

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    // Call Api
    var response = await http.patch(
      Uri.parse('${basedUri}/profile/${currentUser.id}/password'),
      headers: requestHeaders,
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }
}
