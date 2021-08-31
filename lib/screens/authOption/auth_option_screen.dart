import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signin/signin_screen.dart';
import 'package:haiya_client/screens/term_agreement/term_agreement_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import 'widgets/divider_with_text.dart';

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
                width: 200,
                height: 200,
              ),
              Text(
                'HAIYA',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Thailand's First Online Pharmacy",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              CustomBtn(
                text: "SIGN IN",
                boxColor: kSuccessColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          SignInScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                textColor: Colors.white,
              ),
              DividerWithText(),
              CustomBtn(
                text: "SIGN UP",
                boxColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          TermAgreementScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                textColor: Colors.black,
                isBorder: true,
              ),
              Spacer(),
              Text(
                "HaiYa Company Limited ®",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: kDefaultPadding / 2),
            ],
          ),
        ),
      ),
    );
  }
}
