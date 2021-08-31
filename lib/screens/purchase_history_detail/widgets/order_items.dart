import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';

import '../../../constants.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({
    Key? key,
    required this.orderLine,
  }) : super(key: key);

  final List<OrderLine> orderLine;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orderLine.length,
      itemBuilder: (context, index) {
        var orderLineItem = orderLine[index];
        return _buildCartItem(orderLineItem, context);
      },
    );
  }

  Widget _buildCartItem(OrderLine orderLineItem, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderLineItem.productName,
                  overflow: TextOverflow.ellipsis,
                ),
                orderLineItem.comment != ''
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding / 2.5),
                        child: Text(
                          orderLineItem.comment!,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(width: kDefaultPadding / 2),
          Expanded(
            flex: 1,
            child: Text(
              'x ${orderLineItem.quantity}',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${orderLineItem.totalCost} THB',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
