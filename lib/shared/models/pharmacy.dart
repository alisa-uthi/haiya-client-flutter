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

  Pharmacy({
    required this.id,
    required this.pharmacyId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
    this.products,
  });
}
