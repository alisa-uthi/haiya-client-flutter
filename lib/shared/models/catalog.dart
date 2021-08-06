class Catalog {
  final String pharmacyName;
  final int productId;
  final int lot;
  final int availQty;
  final int price;
  final String exp;

  Catalog({
    required this.pharmacyName,
    required this.productId,
    required this.lot,
    required this.availQty,
    required this.price,
    required this.exp,
  });
}
