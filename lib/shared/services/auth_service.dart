import 'dart:convert';

import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var basedUri = 'http://10.0.2.2:8080/api';

  Future<UserDetail> signUp(
    String? email,
    String? password,
    String? title,
    String? firstName,
    String? lastName,
    String? gender,
    String? height,
    String? weight,
    String? phone,
    String? addrRoom,
    String? addrFloor,
    String? addrNo,
    String? addrMoo,
    String? addrSoi,
    String? addrRoad,
    String? addrSubDistrict,
    String? addrDistrict,
    String? addrProvince,
    String? addrPostalCode,
    String? dob,
    List<String>? congentialDisease,
    List<String>? drugAllergy,
  ) async {
    print("""
      $email,
      $password,
      $title,
      $firstName,
      $lastName,
      $gender,
      $height,
      $weight,
      $phone,
      $addrRoom,
      $addrFloor,
      $addrNo,
      $addrMoo,
      $addrSoi,
      $addrRoad,
      $addrSubDistrict,
      $addrDistrict,
      $addrProvince,
      $addrPostalCode,
      $dob,
      ${congentialDisease!.length.toString()},
      ${drugAllergy!.length.toString()},
    """);
    return currentUser;
    // var signupResponse = await http.post(
    //   Uri.parse('$basedUri/auth/signup'),
    //   headers: {
    //     "Content-Type": "application/json; charset=utf-8",
    //   },
    //   body: jsonEncode({
    //     'title': title,
    //     'firstName': firstName,
    //     'lastName': lastName,
    //     'dob': dob,
    //     'gender': gender,
    //     'height': int.parse(height!),
    //     'weight': int.parse(weight!),
    //     'email': email,
    //     'password': password,
    //     'phone': phone
    //   }),
    // );
    // print("RES " + signupResponse.body);

    // if (signupResponse.statusCode >= 200 && signupResponse.statusCode < 205) {
    //   currentUser = UserDetail.fromJson(jsonDecode(signupResponse.body));

    //   print("User 1 = " + currentUser.id.toString());

    //   var addressResponse = await http.post(
    //     Uri.parse('$basedUri/address'),
    //     headers: {
    //       "Content-Type": "application/json; charset=utf-8",
    //     },
    //     body: jsonEncode(
    //       {
    //         'userId': currentUser.id,
    //         'room': addrRoom,
    //         'floor': addrFloor != null ? int.tryParse(addrFloor) : null,
    //         'addrNo': addrNo,
    //         'moo': addrMoo != null ? int.tryParse(addrMoo) : null,
    //         'soi': addrSoi,
    //         'road': addrRoad,
    //         'subdistrict': addrSubDistrict,
    //         'district': addrDistrict,
    //         'province': addrProvince,
    //         'postalCode':
    //             addrPostalCode != null ? int.tryParse(addrPostalCode) : null,
    //       },
    //     ),
    //   );
    //   print("Addr " + addressResponse.statusCode.toString());
    //   if (addressResponse.statusCode >= 200 &&
    //       addressResponse.statusCode < 205) {
    //     var addressResult = jsonDecode(addressResponse.body);
    //     var personalAddrResponse = await http.post(
    //       Uri.parse('$basedUri/address/personal-address'),
    //       headers: {
    //         "Content-Type": "application/json; charset=utf-8",
    //       },
    //       body: jsonEncode(
    //         {'userId': currentUser.id, 'addrId': addressResult['ID']},
    //       ),
    //     );

    //     if (personalAddrResponse.statusCode >= 200 &&
    //         personalAddrResponse.statusCode < 205) {
    //       print("Success Sign up");
    //     }
    //   }
    // }
  }

  Future<dynamic> signIn(
    String email,
    String password,
  ) async {
    print("Submit signin: " + email + " " + password);
  }

  Future<dynamic> forgotPassword(
    String email,
  ) async {
    print("Submit forgot password: " + email);
  }
}
