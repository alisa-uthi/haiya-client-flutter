class Product {
  final int id;
  final String tradeName;
  final String? tradeCode;
  final String? companyName;
  final String? genericAdvice;
  final String detail;
  final String presReq;
  final String? genericName;
  final String? category;
  final String image;
  final int qtyUnit;
  final int? pharmacyId;
  final String? pharmacyName;
  final int availableQty;
  final int price;
  final String expireDate;

  Product({
    required this.id,
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
    this.pharmacyId,
    this.pharmacyName,
    required this.availableQty,
    required this.price,
    required this.expireDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      tradeName: json['Prd_TradeName'],
      tradeCode: json['Prd_TradeCode'],
      companyName: json['Prd_CompName'],
      genericName: json['Prd_GenericName'],
      genericAdvice: json['Prd_GenericAdvice'],
      presReq: json['Prd_Prereq'],
      detail: json['Prd_Detail'],
      qtyUnit: json['Prd_PrdQtyUnit'],
      category: json['Category'],
      image: json['Prd_Image'],
      pharmacyId: json['Pcy_ID'],
      pharmacyName: json['Pcy_Name'],
      availableQty: json['AvailQty'],
      expireDate: json['ExpireDate'],
      price: json['Price'],
    );
  }
}
