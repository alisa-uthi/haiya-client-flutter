import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signin/widgets/signin_form.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class SignInScreen extends StatelessWidget {
  static final routeName = '/signin';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: "Login"),
                SizedBox(height: kDefaultPadding),
                SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
