import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signup/widgets/signup_form.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = '/signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: "Sign up"),
                Text(
                  "Please insert patient’s information",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: kDefaultPadding),
                SignUpForm(),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
