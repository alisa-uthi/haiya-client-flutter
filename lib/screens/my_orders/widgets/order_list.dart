import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order.dart';

import '../../../constants.dart';
import 'order_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
    required List<Order>? orders,
  })  : _orders = orders,
        super(key: key);

  final List<Order>? _orders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            ...List.generate(
              _orders!.length,
              (index) {
                var order = _orders![index];
                return OrderItem(order: order);
              },
            ),
          ],
        ),
      ),
    );
  }
}
