class OrderLine {
  int? orderId;
  int productId;
  String productName;
  String? productImage;
  int? productPrice;
  int quantity;
  int totalCost;
  String? comment;

  OrderLine({
    this.orderId,
    required this.productId,
    required this.productName,
    this.productImage,
    this.productPrice,
    required this.quantity,
    required this.totalCost,
    this.comment,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    return OrderLine(
      orderId: json['Ord_ID'],
      productId: json['Prd_ID'],
      productName: json['Prd_TradeName'],
      productImage: json['Prd_Image'],
      quantity: json['Order_Qty'],
      totalCost: json['Total_Cost'],
      comment: json['Comment'],
    );
  }

  factory OrderLine.fromCartJson(Map<String, dynamic> json) {
    return OrderLine(
      productId: json['Prd_ID'],
      productName: json['Prd_Name'],
      productImage: json['Prd_Image'],
      productPrice: (json['Total_Cost'] / json['Prd_Qty']).toInt(),
      quantity: json['Prd_Qty'],
      totalCost: json['Total_Cost'],
      comment: json['Comment'],
    );
  }
}

List<OrderLine> cart = [];
int cartId = 0;
