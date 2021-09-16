import 'package:flutter/material.dart';
import 'package:haiya_client/screens/delivery_tracking/delivery_tracking_screen.dart';
import 'package:haiya_client/screens/rate_pharmacy/rate_pharmacy_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';

class RatePharmacyButton extends StatelessWidget {
  const RatePharmacyButton({
    Key? key,
    required this.pharmacyName,
  }) : super(key: key);

  final String pharmacyName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: kDefaultPadding * 2),
        CustomBtn(
          text: "Rate Pharmacy",
          boxColor: kPrimaryColor,
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    RatePharmacyScreen(pharmacyName: pharmacyName),
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
