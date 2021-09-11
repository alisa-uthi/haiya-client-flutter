import 'package:flutter/material.dart';
import 'package:haiya_client/screens/forgot_password/forgot_password_screen.dart';

import '../../constants.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ForgotPasswordScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Text(
        "Forgot your password?",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: kGreyColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
