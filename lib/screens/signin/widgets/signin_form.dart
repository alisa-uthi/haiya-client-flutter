import 'package:flutter/material.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/forgot_password_text.dart';
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
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      _isPassHidden = !_isPassHidden;
    });
  }

  void onPressLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isSignin = await _authService.signIn(_email, _password);
      if (isSignin) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HomeScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
          (route) => false,
        );
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Invalid credentials. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Email and password fields
          _formFields.buildEmailField(
            "Email",
            _email,
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding),
          _formFields.buildPasswordField(
              "Password",
              _password,
              (value) => setState(() => _password = value!),
              _isPassHidden,
              _togglePasswordVisibility),
          SizedBox(height: kDefaultPadding),

          // Forgot password
          ForgotPasswordText(),
          SizedBox(height: kDefaultPadding * 3),

          // Login button
          CustomBtn(
            text: "LOGIN",
            boxColor: kPrimaryColor,
            textColor: Colors.white,
            onPressed: () => onPressLogin(context),
          ),
        ],
      ),
    );
  }
}
