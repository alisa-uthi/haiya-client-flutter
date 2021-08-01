import 'package:flutter/material.dart';

class UserDetail {
  String firstname;
  String lastname;
  String dob;
  String gender;
  String phone;
  String address;
  String? email;

  UserDetail({
    required this.dob,
    required this.firstname,
    required this.gender,
    required this.lastname,
    required this.phone,
    required this.address,
    this.email,
  });
}

UserDetail currentUser = UserDetail(
  firstname: "Benimaru",
  lastname: "Shinmon",
  gender: "Male",
  phone: "038-485-2394",
  dob: "1999-02-24",
  address: "Kratum Lom, Salaya, Nakhorn Pathom",
);
