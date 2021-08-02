import 'package:haiya_client/shared/models/user_detail.dart';

class AuthService {
  // TODO: Call API
  Future<UserDetail> signUp(
    String email,
    String password,
    String title,
    String firstName,
    String lastName,
    String gender,
    String height,
    String weight,
    String phone,
    String addrRoom,
    String addrFloor,
    String addrNo,
    String addrMoo,
    String addrSoi,
    String addrRoad,
    String addrSubDistrict,
    String addrDistrict,
    String addrProvince,
    String addrPostalCode,
    String dob,
    List<String> congentialDisease,
    List<String> drugAllergy,
  ) async {
    currentUser = UserDetail(
      email: email,
      password: password,
      title: title,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      height: height as int,
      weight: weight as int,
      phone: phone,
      addrRoom: addrRoom,
      addrFloor: addrFloor,
      addrNo: addrNo,
      addrMoo: addrMoo,
      addrSoi: addrSoi,
      addrRoad: addrRoad,
      addrSubDistrict: addrSubDistrict,
      addrDistrict: addrDistrict,
      addrProvince: addrProvince,
      addrPostalCode: addrPostalCode,
      dob: dob,
      congentialDisease: congentialDisease,
      drugAllergy: drugAllergy,
    );
    return currentUser;
  }

  Future<dynamic> signIn(
    String email,
    String password,
  ) async {
    print("Submit signin: " + email + " " + password);
  }
}
