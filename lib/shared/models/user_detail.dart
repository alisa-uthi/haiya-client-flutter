import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'congenital_disease.dart';
import 'drug_allergy.dart';

class UserDetail {
  final int id;
  String email;
  String password;
  String title;
  String firstname;
  String lastname;
  String gender;
  int? height;
  int? weight;
  String phone;
  String dob;
  String image;
  List<CongenitalDisease> congenitalDisease;
  List<DrugAllergy> drugAllergy;
  String token;

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
    required this.image,
    required this.congenitalDisease,
    required this.drugAllergy,
    this.token = '',
  });

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
      drugAllergy: json['Psn_DrugAllergy'] != null
          ? (json['Psn_DrugAllergy'] as List)
              .map((i) => DrugAllergy.fromJson(i))
              .toList()
          : [],
      congenitalDisease: json['Psn_CongenitalDisease'] != null
          ? (json['Psn_CongenitalDisease'] as List)
              .map((i) => CongenitalDisease.fromJson(i))
              .toList()
          : [],
    );
  }

  @override
  String toString() {
    return """${this.id}, ${this.title}, ${this.firstname}, ${this.lastname}, ${this.dob}, 
    ${this.gender}, ${this.weight}, ${this.height}, ${this.phone},
    ${this.email}, ${this.password}, ${this.image} 
    ${this.drugAllergy} ${this.congenitalDisease}""";
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
  height: null,
  weight: null,
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
);

LatLng latlng = new LatLng(10.00, 10.00);
