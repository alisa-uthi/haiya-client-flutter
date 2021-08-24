import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/services/auth_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  String _email = '';
  AuthService _authService = new AuthService();
  FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  void sendRequest(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      print(_email);
      bool isRequestSuccess = await _authService.forgotPassword(_email);
      print(isRequestSuccess);
      if (isRequestSuccess) {
        CustomSnackBar.buildSnackbar(
          context,
          'The request has been sent. Please check your email.',
        );

        Future.delayed(const Duration(milliseconds: 3000), () {
          Navigator.pop(context);
        });
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Invalid Email. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _formFields.buildEmailField(
            "Email",
            (value) => setState(() => _email = value!),
          ),
          SizedBox(height: kDefaultPadding * 2),
          CustomBtn(
            text: "SEND",
            boxColor: kPrimaryColor,
            onPressed: () => sendRequest(context),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
