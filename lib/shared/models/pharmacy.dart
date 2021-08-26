import 'address.dart';
import 'operation_time.dart';

class Pharmacy {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String image;
  final String? ratingScore;
  final int? addressId;
  final Address? address;
  final double? distanceFromCurrentLoc;
  final List<OperationTime>? operationTime;

  Pharmacy({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.image,
    this.ratingScore,
    this.addressId,
    this.address,
    this.distanceFromCurrentLoc,
    this.operationTime,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['ID'],
      name: json['Pcy_Name'],
      email: json['Pcy_Email'],
      phone: json['Pcy_Phone'],
      image: json['Pcy_Image'],
      ratingScore: json['Rating_Score'],
      distanceFromCurrentLoc: json['Distance'],
      addressId: json['Pcy_Addr_ID'],
      address: json['Pcy_Address'] != null
          ? Address.fromJson(json['Pcy_Address'])
          : null,
      operationTime: json['Pcy_OperationTimes'] != null
          ? (json['Pcy_OperationTimes'] as List)
              .map((i) => OperationTime.fromJson(i))
              .toList()
          : null,
    );
  }
}

List<Pharmacy> allPharmacies = [];
List<Pharmacy> nearestPharmacies = [];
