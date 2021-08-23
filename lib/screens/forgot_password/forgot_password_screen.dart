import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/forgot_password/widgets/forgot_password_form.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static final routeName = '/forgot-password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText(text: "Forgot Password"),
              SizedBox(height: kDefaultPadding),
              Text(
                "Please, enter your email address. You will receive a link to create a new password via email.",
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              ForgotPasswordForm()
            ],
          ),
        ),
      ),
    );
  }
}
