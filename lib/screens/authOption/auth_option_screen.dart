import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signin/signin_screen.dart';
import 'package:haiya_client/screens/signup/signup_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

class AuthOptionScreen extends StatelessWidget {
  static final routeName = '/auth-option';

  const AuthOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/images/haiya_logo.png',
                width: 270,
                height: 270,
              ),
              Text(
                'HAIYA',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Thailand's First Online Pharmacy",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              CustomBtn(
                text: "SIGN IN",
                boxColor: kSuccessColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, SignInScreen.routeName);
                },
                textColor: Colors.white,
              ),
              _buildDividerWithText(),
              CustomBtn(
                text: "SIGN UP",
                boxColor: kBackgroundColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, SignUpScreen.routeName);
                },
                textColor: Colors.black,
                isBorder: true,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 2,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(width: kDefaultPadding / 2),
        Text(
          "OR",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: kDefaultPadding / 2),
        Expanded(
          child: Divider(
            thickness: 2,
            color: kPrimaryColor,
          ),
        ),
      ]),
    );
  }
}
