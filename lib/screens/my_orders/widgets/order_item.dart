import 'package:flutter/material.dart';
import 'package:haiya_client/screens/order_detail/order_detail_screen.dart';
import 'package:haiya_client/shared/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "${order.payTimestamp}, ${order.pharmacyName}",
        style: Theme.of(context).textTheme.bodyText1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => OrderDetailScreen(
              orderId: order.id,
              isDelivering: order.orderStatus == 'PICKED_UP' ? true : false,
              isCompleted: order.orderStatus == 'DELIVERED' ? true : false,
            ),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
    );
  }
}
