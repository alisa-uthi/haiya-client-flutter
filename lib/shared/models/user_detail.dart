import 'package:haiya_client/shared/models/congenital_disease.dart';
import 'package:haiya_client/shared/models/drug_allergy.dart';

import 'address.dart';

class UserDetail {
  final int id;
  String email;
  String password;
  String title;
  String firstname;
  String lastname;
  String gender;
  int height;
  int weight;
  String phone;
  String dob;
  String? image;
  List<CongenitalDisease>? congenitalDisease;
  List<DrugAllergy>? drugAllergy;
  List<Address>? address;

  UserDetail({
    required this.id,
    required this.email,
    required this.password,
    required this.title,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.height,
    required this.weight,
    required this.phone,
    required this.dob,
    this.image,
    this.congenitalDisease,
    this.drugAllergy,
    this.address,
  });

  set _title(String value) {
    this.title = value;
  }

  set _firstname(String value) {
    this.firstname = value;
  }

  set _lastname(String value) {
    this.lastname = value;
  }

  set _gender(String value) {
    this.gender = value;
  }

  set _dob(String value) {
    this.dob = value;
  }

  set _weight(int value) {
    this.weight = value;
  }

  set _height(int value) {
    this.height = value;
  }

  set _phone(String value) {
    this.phone = value;
  }

  set _email(String value) {
    this.email = value;
  }

  set _password(String value) {
    this.password = value;
  }

  set _congenitalDisease(List<CongenitalDisease> disease) {
    this.congenitalDisease = disease;
  }

  set _drugAllergy(List<DrugAllergy> allergy) {
    this.drugAllergy = allergy;
  }

  set _address(List<Address> address) {
    this.address = address;
  }

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['ID'],
      email: json['Psn_Email'],
      password: json['Psn_Password'],
      title: json['Psn_Title'],
      firstname: json['Psn_Fname'],
      lastname: json['Psn_Lname'],
      dob: json['Psn_DoB'],
      gender: json['Psn_Gender'],
      height: json['Psn_Height'],
      weight: json['Psn_Weight'],
      phone: json['Psn_Phone'],
      image: json['Psn_Image'],
    );
  }

  @override
  String toString() {
    return """${this.id}, ${this.title}, ${this.firstname}, ${this.lastname}, ${this.dob}, 
    ${this.gender}, ${this.weight}, ${this.height}, ${this.phone},
    ${this.email}, ${this.password}, ${this.image}""";
  }
}

UserDetail tempUser = new UserDetail(
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
  image: '',
  congenitalDisease: [],
  drugAllergy: [],
);

UserDetail currentUser = new UserDetail(
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
  image: '',
  congenitalDisease: [],
  drugAllergy: [],
  address: [],
);
