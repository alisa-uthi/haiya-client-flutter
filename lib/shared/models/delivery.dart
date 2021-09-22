import 'package:intl/intl.dart';

class Delivery {
  int id;
  int orderId;
  int driverId;
  String status;
  String timestamp;

  Delivery({
    required this.id,
    required this.orderId,
    required this.driverId,
    required this.status,
    required this.timestamp,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['ID'],
      orderId: json['Ord_ID'],
      driverId: json['Driver_ID'],
      status: json['Del_Status'],
      timestamp: DateFormat.yMMMMd('en_US')
          .add_jm()
          .format(DateTime.parse(json['Del_Timestamp'])),
    );
  }
}
