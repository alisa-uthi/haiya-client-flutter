import 'package:flutter/material.dart';
import 'package:haiya_client/screens/delivery_tracking/delivery_tracking_screen.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';

class ButtonGroup extends StatefulWidget {
  const ButtonGroup({
    Key? key,
  }) : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kDefaultPadding,
        0,
        kDefaultPadding,
        kDefaultPadding * 2,
      ),
      child: Column(
        children: [
          CustomBtn(
            text: "CONTINUE SHOPPING",
            boxColor: kPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      HomeScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            textColor: Colors.white,
          ),
          SizedBox(height: kDefaultPadding * 1.2),
          CustomBtn(
            text: "DELIVERY TRACKING",
            boxColor: kSecondaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      DeliveryTrackingScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
