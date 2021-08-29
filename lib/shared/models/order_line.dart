class OrderLine {
  int? orderId;
  int productId;
  String productName;
  int quantity;
  int totalCost;
  String? comment;

  OrderLine({
    this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalCost,
    this.comment,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) {
    return OrderLine(
      orderId: json['Ord_ID'],
      productId: json['Prd_ID'],
      productName: json['productName'],
      quantity: json['Order_Qty'],
      totalCost: json['Total_Cost'],
      comment: json['Comment'],
    );
  }
}

List<OrderLine> cart = [];
