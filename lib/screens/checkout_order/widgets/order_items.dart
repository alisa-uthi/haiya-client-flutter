import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';

import '../../../constants.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cart.length,
        itemBuilder: (context, index) {
          var cartItem = cart[index];
          return _buildCartItem(cartItem, context);
        },
      ),
    );
  }

  Widget _buildCartItem(OrderLine cartItem, BuildContext context) {
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
                  cartItem.productName,
                  overflow: TextOverflow.ellipsis,
                ),
                cartItem.comment != ''
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding / 2.5),
                        child: Text(
                          cartItem.comment!,
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
              'x ${cartItem.quantity}',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${cartItem.totalCost} THB',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
