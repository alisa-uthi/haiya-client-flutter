import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/title_with_price.dart';

import '../../../constants.dart';
import 'order_items.dart';

class OrderSummarySection extends StatefulWidget {
  const OrderSummarySection({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  _OrderSummarySectionState createState() => _OrderSummarySectionState();
}

class _OrderSummarySectionState extends State<OrderSummarySection> {
  int _computeOrderTotalCost() {
    int orderTotalCost = 0;
    widget.order.orderLines!.forEach((orderLine) {
      orderTotalCost += orderLine.totalCost;
    });
    return orderTotalCost;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: TextStyle(
            color: kGreyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              children: [
                OrderItems(orderLine: widget.order.orderLines!),
                SizedBox(height: kDefaultPadding / 2),
                Divider(thickness: 2),
                TitleWithPrice(
                  title: "Order Total Cost",
                  price: _computeOrderTotalCost(),
                  color: Colors.black54,
                ),
                SizedBox(height: kDefaultPadding / 2),
                TitleWithPrice(
                  title: "Delivery Fee",
                  price: widget.order.deliveryPrice,
                  color: Colors.black54,
                ),
                Divider(thickness: 2),
                SizedBox(height: kDefaultPadding),
                TitleWithPrice(
                  title: "Total",
                  price: _computeOrderTotalCost() + widget.order.deliveryPrice,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
