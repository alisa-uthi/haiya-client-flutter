import 'package:flutter/material.dart';
import 'package:haiya_client/screens/forgot_password/forgot_password_screen.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

import '../../../constants.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String _email = '', _password = '';
  bool _isPassHidden = true;

  AuthService _authService = new AuthService();
  FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _isPassHidden = !_isPassHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _formFields.buildEmailField(
            "Email",
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding),
          _formFields.buildPasswordField(
              "Password",
              (value) => setState(() => _password = value!),
              _isPassHidden,
              _togglePasswordVisibility),
          SizedBox(height: kDefaultPadding),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: Text(
              "Forgot your password?",
              textAlign: TextAlign.right,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: kDefaultPadding * 3),
          CustomBtn(
            text: "LOGIN",
            boxColor: kPrimaryColor,
            textColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authService.signIn(_email, _password);
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
