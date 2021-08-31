import 'package:haiya_client/shared/models/order_line.dart';

class Order {
  int id;
  String deliveryAddress;
  int deliveryPrice;
  String paymentMethod;
  String payTimestamp;
  String? comment;
  String orderStatus;
  int userId;
  String pharmacyName;
  List<OrderLine>? orderLines;

  Order(
      {required this.id,
      required this.deliveryAddress,
      required this.deliveryPrice,
      required this.paymentMethod,
      required this.payTimestamp,
      required this.userId,
      required this.pharmacyName,
      required this.orderStatus,
      this.comment,
      this.orderLines});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['ID'],
      deliveryAddress: json['Ord_DelAddr'],
      deliveryPrice: json['Ord_DelPrice'],
      paymentMethod: json['Ord_PayMethod'],
      payTimestamp: json['Ord_PayTimestamp'],
      comment: json['Ord_Comment'],
      userId: json['Ord_Psn_ID'],
      pharmacyName: json['Ord_Pharmacy'],
      orderStatus: json['Ord_OrderStatus'],
      orderLines: json['orderLines'] != null
          ? (json['orderLines'] as List)
              .map((orderLine) => OrderLine.fromJson(orderLine))
              .toList()
          : null,
    );
  }
}
