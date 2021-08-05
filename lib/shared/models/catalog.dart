class Catalog {
  final int pharmacyId;
  final int productId;
  final int lot;
  final int availQty;
  final int price;
  final String exp;

  Catalog({
    required this.pharmacyId,
    required this.productId,
    required this.lot,
    required this.availQty,
    required this.price,
    required this.exp,
  });
}
