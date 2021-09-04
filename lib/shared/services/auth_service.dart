import 'dart:convert';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var basedUri = 'http://10.0.2.2:8080/api/user/auth';

  Future<bool> signUp() async {
    var drugAllergy = [];
    var congenitalDisease = [];

    // Convert List<DrugAllery> to normal array of objects
    if (tempUser.drugAllergy.length > 0) {
      for (int i = 0; i < tempUser.drugAllergy.length; i++) {
        var obj = {
          'name': tempUser.drugAllergy[i].name!,
          'reaction': tempUser.drugAllergy[i].reaction!,
          'severity': tempUser.drugAllergy[i].severity!,
        };
        drugAllergy.add(obj);
      }
    }

    // Convert List<DrugAllery> to normal array of objects
    if (tempUser.congenitalDisease.length > 0) {
      for (int i = 0; i < tempUser.congenitalDisease.length; i++) {
        var obj = {
          'name': tempUser.congenitalDisease[i].name!,
          'reaction': tempUser.congenitalDisease[i].reaction!,
          'severity': tempUser.congenitalDisease[i].severity!,
        };
        congenitalDisease.add(obj);
      }
    }

    // Call Api
    var response = await http.post(
      Uri.parse('$basedUri/signup/'),
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
        'password': tempUser.password,
        'phone': tempUser.phone,
        'drugAllergy': drugAllergy.length > 0 ? drugAllergy : null,
        'congenitalDisease':
            congenitalDisease.length > 0 ? congenitalDisease : null,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
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
        height: null,
        weight: null,
        phone: '',
        dob: '',
        image: '',
        congenitalDisease: [],
        drugAllergy: [],
      );

      return true;
    }

    return false;
  }

  Future<bool> signIn(String email, String password) async {
    // Call Api
    var response = await http.post(
      Uri.parse('$basedUri/signin/'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      // Convert response body to UserDetail object
      Map<String, dynamic> body = jsonDecode(response.body);
      currentUser = UserDetail.fromJson(body['user']);

      return true;
    }
    return false;
  }

  Future<bool> forgotPassword(String email) async {
    // Call Api
    var response = await http.post(
      Uri.parse('$basedUri/request-reset-password/'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({'email': email}),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }
}
