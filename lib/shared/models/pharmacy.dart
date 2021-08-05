import 'package:haiya_client/shared/models/operation_time.dart';
import 'package:haiya_client/shared/models/product.dart';

import 'address.dart';

class Pharmacy {
  final int id;
  final String pharmacyId;
  final String name;
  final String email;
  final String phone;
  final String image;
  final Address address;
  final List<Product>? products;
  final String?
      distanceFromCurrentLoc; //TODO: Get this from backend, calculate the current loc and loc of pharmacy
  final OperationTime
      operationTime; // TODO: Get this from backend. If it is matched with the Date.now(), retrieve info and send it back here.

  Pharmacy({
    required this.id,
    required this.pharmacyId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
    this.products,
    this.distanceFromCurrentLoc,
    required this.operationTime,
  });
}
