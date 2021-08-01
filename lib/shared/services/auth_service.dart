import 'package:haiya_client/shared/models/user_detail.dart';

class AuthService {
  // TODO: Call API
  Future<UserDetail> signUp(
    String firstname,
    String lastname,
    String gender,
    String dob,
    String phone,
    String address,
    String email,
  ) async {
    currentUser = UserDetail(
      firstname: firstname,
      lastname: lastname,
      gender: gender,
      dob: dob,
      phone: phone,
      address: address,
      email: email,
    );
    return currentUser;
  }

  Future<dynamic> signIn(
    String email,
    String password,
  ) async {
    print("Submit signin: " + email + " " + password);
  }

  Future<UserDetail> updateUserInfo(
    String firstname,
    String lastname,
    String gender,
    String dob,
    String phone,
    String address,
    String email,
  ) async {
    currentUser = UserDetail(
      firstname: firstname,
      lastname: lastname,
      gender: gender,
      dob: dob,
      phone: phone,
      address: address,
      email: email,
    );
    return currentUser;
  }
}
