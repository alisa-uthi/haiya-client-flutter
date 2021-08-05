import 'package:haiya_client/shared/models/catalog.dart';
import 'package:haiya_client/shared/models/productCategory.dart';
import 'package:haiya_client/shared/models/productGenericName.dart';
import 'package:haiya_client/shared/models/productImage.dart';

class Product {
  final int id;
  final String productId;
  final String tradeName;
  final String? tradeCode;
  final String? companyName;
  final String? genericAdvice;
  final String presReq;
  final List<ProductGenericName>? genericName;
  final List<ProductCategory> category;
  final List<ProductImage> image;
  final int qtyUnit;
  final String detail;
  final Catalog catalog;

  Product({
    required this.id,
    required this.productId,
    required this.tradeName,
    this.tradeCode,
    this.companyName,
    this.genericAdvice,
    required this.presReq,
    this.genericName,
    required this.category,
    required this.image,
    required this.qtyUnit,
    required this.detail,
    required this.catalog,
  });
}
