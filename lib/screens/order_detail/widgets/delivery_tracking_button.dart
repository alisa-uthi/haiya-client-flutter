import 'package:flutter/material.dart';
import 'package:haiya_client/screens/delivery_tracking/delivery_tracking_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';

class DeliveryTrackingButton extends StatelessWidget {
  const DeliveryTrackingButton({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kDefaultPadding * 2),
        CustomBtn(
          text: "Track Delivery",
          boxColor: kPrimaryColor,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    DeliveryTrackingScreen(
                  orderId: orderId,
                ),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          textColor: Colors.white,
        ),
      ],
    );
  }
}
