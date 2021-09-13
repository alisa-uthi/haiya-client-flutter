import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class PaymentMethodSection extends StatelessWidget {
  final String paymentMethod;

  const PaymentMethodSection({
    Key? key,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: TextStyle(
            color: kGreyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              paymentMethod,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}
