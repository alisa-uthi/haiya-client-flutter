import 'dart:convert';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:http/http.dart' as http;

class AuthService {
  var basedUri = 'http://10.0.2.2:8080/api/user/auth';

  Future<UserDetail?> signUp() async {
    var drugAllergy = [];
    var congenitalDisease = [];

    if (tempUser.drugAllergy!.length > 0) {
      for (int i = 0; i < tempUser.drugAllergy!.length; i++) {
        var obj = {
          'name': tempUser.drugAllergy![i].name!,
          'reaction': tempUser.drugAllergy![i].reaction!,
          'severity': tempUser.drugAllergy![i].severity!,
        };
        drugAllergy.add(obj);
      }
    }

    if (tempUser.congenitalDisease!.length > 0) {
      for (int i = 0; i < tempUser.congenitalDisease!.length; i++) {
        var obj = {
          'name': tempUser.congenitalDisease![i].name!,
          'reaction': tempUser.congenitalDisease![i].reaction!,
          'severity': tempUser.congenitalDisease![i].severity!,
        };
        congenitalDisease.add(obj);
      }
    }

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

    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      currentUser = UserDetail.fromJson(body['data']);

      // Reset user info when sign up
      // tempUser = new UserDetail(
      //     id: 0,
      //     email: '',
      //     password: '',
      //     title: 'Mr.',
      //     firstname: '',
      //     lastname: '',
      //     gender: 'M',
      //     height: 0,
      //     weight: 0,
      //     phone: '',
      //     dob: '',
      //     congenitalDisease: [],
      //     drugAllergy: []);

      return currentUser;
    }
    return null;
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
