import 'address.dart';
import 'operation_time.dart';

class Pharmacy {
  final int id;
  final String name;
  final String? email;
  final String phone;
  final String image;
  final String? ratingScore;
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
      address: Address.fromJson(json['Pcy_Address']),
      operationTime: (json['Pcy_OperationTimes'] as List)
          .map((i) => OperationTime.fromJson(i))
          .toList(),
    );
  }
}

List<Pharmacy> nearestPharmacies = [];
