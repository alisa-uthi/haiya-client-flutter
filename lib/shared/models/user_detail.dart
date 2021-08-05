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
  final String? addrRoom;
  final int? addrFloor;
  final String? addrNo;
  final int? addrMoo;
  final String? addrSoi;
  final String? addrRoad;
  final String? addrSubDistrict;
  final String? addrDistrict;
  final String? addrProvince;
  final int? addrPostalCode;
  final String? image;
  List<String>? congentialDisease;
  List<String>? drugAllergy;

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
    this.addrRoom,
    this.addrFloor,
    this.addrNo,
    this.addrMoo,
    this.addrSoi,
    this.addrRoad,
    this.addrSubDistrict,
    this.addrDistrict,
    this.addrProvince,
    this.addrPostalCode,
    this.image,
    this.congentialDisease,
    this.drugAllergy,
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
      addrDistrict: json['Addr_District'],
      addrNo: json['Addr_AddrNo'],
      addrPostalCode: json['Addr_Postalcode'],
      addrProvince: json['Addr_Province'],
      addrRoad: json['Addr_Road'],
      addrSubDistrict: json['Addr_Subdistrict'],
      addrFloor: json['Addr_Floor'],
      addrMoo: json['Addr_Moo'],
      addrRoom: json['Addr_Room'],
      addrSoi: json['Addr_Soi'],
    );
  }
}

UserDetail currentUser = UserDetail(
  id: 1,
  userId: 'PSN00001',
  firstName: "Benimaru",
  lastName: "Shinmon",
  gender: "Male",
  phone: "0804488048",
  dob: "1999-02-24",
  addrDistrict: 'district',
  addrNo: '123/23',
  addrPostalCode: 123123,
  addrProvince: 'bkk',
  addrRoad: 'road',
  addrSubDistrict: 'subdistrict',
  height: 155,
  email: 'example@example.com',
  password: '',
  title: 'Mr.',
  weight: 155,
);
