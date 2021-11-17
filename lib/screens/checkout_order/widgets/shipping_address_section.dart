import 'package:flutter/material.dart';
import 'package:haiya_client/screens/shipping_address/shipping_address_screen.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class ShippingAddressSection extends StatefulWidget {
  const ShippingAddressSection({
    Key? key,
    required this.addressName,
    required this.deliveryAddress,
    required this.onAddressChanged,
  }) : super(key: key);

  final String addressName;
  final String deliveryAddress;
  final Function onAddressChanged;

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
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.addressName),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                ShippingAddressScreen(),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        ).then((value) => widget.onAddressChanged());
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kDefaultPadding / 2),
                Text(
                  widget.deliveryAddress,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: kDefaultPadding / 2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
