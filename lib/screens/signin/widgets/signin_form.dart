import 'package:flutter/material.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String _email = '';
  String _password = '';
  AuthService _authService = new AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // AccountFields.buildEmailField(
          //   context,
          //   (value) => setState(() => _email = value),
          // ),
          // SizedBox(height: kDefaultPadding),
          // AccountFields.buildPasswordField(
          //   context,
          //   (value) => setState(() => _password = value),
          //   false,
          // ),
          SizedBox(height: kDefaultPadding * 2),
          CustomBtn(
            text: "Sign in",
            boxColor: kSuccessColor,
            textColor: Colors.white,
            onPressed: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (_formKey.currentState!.validate()) {
                  _authService.signIn(_email, _password);
                  // Navigator.pushNamed(context, SignInScreen.routeName);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
