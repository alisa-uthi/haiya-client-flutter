import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

import 'widgets/button_group.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  static final routeName = '/checkout-success';

  const CheckoutSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            'assets/images/checkout_success.png',
            width: 250,
            height: 250,
          ),
          SizedBox(height: kDefaultPadding),
          Text(
            "Success!",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            "Your order will be delivered soon.\nThank you for choosing our app!",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          ButtonGroup(),
        ],
      ),
    );
  }
}
