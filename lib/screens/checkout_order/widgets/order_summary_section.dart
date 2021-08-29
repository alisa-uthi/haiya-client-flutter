import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/title_with_price.dart';

import '../../../constants.dart';
import 'order_items.dart';

class OrderSummarySection extends StatefulWidget {
  const OrderSummarySection({
    Key? key,
  }) : super(key: key);

  @override
  _OrderSummarySectionState createState() => _OrderSummarySectionState();
}

class _OrderSummarySectionState extends State<OrderSummarySection> {
  int _orderTotalPrice = 0;

  @override
  void initState() {
    super.initState();

    int totalPrice = 0;
    for (var orderLine in cart) {
      totalPrice += orderLine.totalCost;
    }
    setState(() => _orderTotalPrice = totalPrice);
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
                OrderItems(),
                SizedBox(height: kDefaultPadding / 2),
                Divider(thickness: 2),
                TitleWithPrice(
                  title: "Order Total Cost",
                  price: _orderTotalPrice,
                  color: Colors.black54,
                ),
                SizedBox(height: kDefaultPadding / 2),
                TitleWithPrice(
                  title: "Delivery Fee",
                  price: 30,
                  color: Colors.black54,
                ),
                Divider(thickness: 2),
                SizedBox(height: kDefaultPadding),
                TitleWithPrice(
                  title: "Total",
                  price: _orderTotalPrice + 30,
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
