import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(
              kDefaultPadding,
              0,
              kDefaultPadding,
              kDefaultPadding * 2,
            ),
            child: CustomBtn(
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
          ),
        ],
      ),
    );
  }
}
