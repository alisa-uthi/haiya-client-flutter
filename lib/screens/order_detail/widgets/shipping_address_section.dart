import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class ShippingAddressSection extends StatefulWidget {
  const ShippingAddressSection({
    Key? key,
    required this.deliveryAddress,
  }) : super(key: key);

  final String deliveryAddress;

  @override
  _ShippingAddressSectionState createState() => _ShippingAddressSectionState();
}

class _ShippingAddressSectionState extends State<ShippingAddressSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shipping address",
          style: TextStyle(
            color: kGreyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Text(
              widget.deliveryAddress,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}
