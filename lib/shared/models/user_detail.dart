class UserDetail {
  String? id;
  String email;
  String password;
  String title;
  String firstName;
  String lastName;
  String gender;
  int height;
  int weight;
  String phone;
  String? addrRoom;
  String? addrFloor;
  String addrNo;
  String? addrMoo;
  String? addrSoi;
  String addrRoad;
  String addrSubDistrict;
  String addrDistrict;
  String addrProvince;
  String addrPostalCode;
  String dob;
  String? image;
  List<String>? congentialDisease;
  List<String>? drugAllergy;

  UserDetail({
    this.id,
    required this.email,
    required this.password,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.height,
    required this.weight,
    required this.phone,
    this.addrRoom,
    this.addrFloor,
    required this.addrNo,
    this.addrMoo,
    this.addrSoi,
    required this.addrRoad,
    required this.addrSubDistrict,
    required this.addrDistrict,
    required this.addrProvince,
    required this.addrPostalCode,
    required this.dob,
    this.image,
    this.congentialDisease,
    this.drugAllergy,
  });
}

UserDetail currentUser = UserDetail(
  id: 'PSN00001',
  firstName: "Benimaru",
  lastName: "Shinmon",
  gender: "Male",
  phone: "038-485-2394",
  dob: "1999-02-24",
  addrDistrict: 'district',
  addrNo: '123/23',
  addrPostalCode: '123123',
  addrProvince: 'bkk',
  addrRoad: 'road',
  addrSubDistrict: 'subdistrict',
  height: 155,
  email: 'example@example.com',
  password: '',
  title: 'Mr.',
  weight: 155,
);
