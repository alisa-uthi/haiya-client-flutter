import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  String? _email;
  FormFields _formFields = new FormFields();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _formFields.buildEmailField(
            "Email",
            (value) => setState(() => _email = value),
          ),
          SizedBox(height: kDefaultPadding * 2),
          CustomBtn(
            text: "SEND",
            boxColor: kPrimaryColor,
            onPressed: () {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (_formKey.currentState!.validate()) {
                  //     _authService.signIn(_email!, _password!);
                  Navigator.pop(context);
                }
              });
            },
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
