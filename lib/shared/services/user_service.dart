import 'dart:convert';
import 'package:haiya_client/shared/models/address.dart';
import 'package:http/http.dart' as http;

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

class UserService {
  var basedUri = 'http://10.0.2.2:8080/api/user';

  Future<void> updateProfileImage(String filePath) async {
    print("Update profile image: " + filePath);
  }

  Future<LatLng> getCurrentCoordinates() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  Future<String> getCurrentLocation() async {
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
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
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
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> getAddressByUserId() async {
    // Call Api
    var response =
        await http.get(Uri.parse('${basedUri}/address/user/${currentUser.id}'));

    // Handle response
    if (response.statusCode == 200) {
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
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'userId': currentUser.id,
        'isDeliveryAddress': isShippingAddress ? 'Y' : 'N',
      }),
    );

    // Handle response
    if (response.statusCode == 200) {
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
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'title': tempUser.title,
        'firstname': tempUser.firstname,
        'lastname': tempUser.lastname,
        'dob': tempUser.dob,
        'gender': tempUser.gender,
        'height': tempUser.height,
        'weight': tempUser.weight,
        'email': tempUser.email,
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
      currentUser = UserDetail.fromJson(body['data']);

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
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
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
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
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
}
