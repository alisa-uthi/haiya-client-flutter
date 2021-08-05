import 'address.dart';

class UserDetail {
  final int id;
  final String userId;
  final String email;
  final String password;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;
  final int height;
  final int weight;
  final String phone;
  final String dob;
  final String? image;
  final List<String>? congentialDisease;
  final List<String>? drugAllergy;
  final Address? address;

  UserDetail({
    required this.id,
    required this.userId,
    required this.email,
    required this.password,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.height,
    required this.weight,
    required this.phone,
    required this.dob,
    this.image,
    this.congentialDisease,
    this.drugAllergy,
    this.address,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['ID'],
      userId: json['Psn_ID'],
      email: json['Psn_Email'],
      password: json['Psn_Password'],
      title: json['Psn_Title'],
      firstName: json['Psn_Fname'],
      lastName: json['Psn_Lname'],
      dob: json['Psn_DoB'],
      gender: json['Psn_Gender'],
      height: json['Psn_Height'],
      weight: json['Psn_Weight'],
      phone: json['Psn_Phone'],
      image: json['Psn_Image'],
    );
  }
}
