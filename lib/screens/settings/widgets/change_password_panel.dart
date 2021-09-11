import 'package:flutter/material.dart';
import 'package:haiya_client/screens/forgot_password/forgot_password_screen.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/forgot_password_text.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

import '../../../constants.dart';

class ChangePasswordPanel extends StatefulWidget {
  const ChangePasswordPanel({
    Key? key,
    required this.scrollController,
    required this.closePanel,
  }) : super(key: key);

  final ScrollController scrollController;
  final Function closePanel;

  @override
  _ChangePasswordPanelState createState() => _ChangePasswordPanelState();
}

class _ChangePasswordPanelState extends State<ChangePasswordPanel> {
  String _oldPassword = '', _newPassword = '', _confirmPass = '';
  bool _isOldPassHidden = true,
      _isNewPassHidden = true,
      _isConfirmPassHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormFields _formFields = new FormFields();
  final UserService _userService = new UserService();

  void onSavePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool isSuccess = await _userService.updatePassword(
        oldPassword: _oldPassword,
        newPassword: _newPassword,
      );

      if (isSuccess) {
        widget.closePanel();
        CustomSnackBar.buildSnackbar(
          context,
          'Your password has been updated.',
        );
        setState(() {
          _oldPassword = '';
          _newPassword = '';
          _confirmPass = '';
          _isOldPassHidden = true;
          _isNewPassHidden = true;
          _isConfirmPassHidden = true;
        });
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Old password is incorrect. Please try again.',
        );
      }
    }
  }

  void _toggleOldPasswordVisibility() {
    setState(() {
      _isOldPassHidden = !_isOldPassHidden;
    });
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _isNewPassHidden = !_isNewPassHidden;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPassHidden = !_isConfirmPassHidden;
    });
  }

  bool _isFormEmpty() {
    if (_oldPassword != '' && _newPassword != '' && _confirmPass != '') {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: ListView(
        controller: widget.scrollController,
        children: [
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Text(
            "Password Change",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kDefaultPadding),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Old Password
                  _formFields.buildPasswordField(
                    "Old Password*",
                    _oldPassword,
                    (value) => setState(() => {
                          _oldPassword = value!,
                        }),
                    _isOldPassHidden,
                    _toggleOldPasswordVisibility,
                  ),
                  SizedBox(height: kDefaultPadding / 2),

                  // Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ForgotPasswordText(),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),

                  // New Password
                  _formFields.buildPasswordField(
                    "New Password*",
                    _newPassword,
                    (value) => setState(() => {
                          _newPassword = value!,
                        }),
                    _isNewPassHidden,
                    _toggleNewPasswordVisibility,
                  ),
                  SizedBox(height: kDefaultPadding / 1.5),

                  // Confirm Password
                  _formFields.buildConfirmPasswordField(
                    "Repeat New Password*",
                    (value) => setState(() => _confirmPass = value!),
                    _newPassword,
                    _isConfirmPassHidden,
                    _toggleConfirmPasswordVisibility,
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                ],
              ),
            ),
          ),

          // Submit Button
          CustomBtn(
            text: "SAVE PASSWORD",
            boxColor: _isFormEmpty() ? kGreyColor : kPrimaryColor,
            textColor: Colors.white,
            onPressed: () => onSavePassword(context),
          ),
          SizedBox(height: kDefaultPadding),

          // Calcel Button
          CustomBtn(
            text: "CANCEL",
            boxColor: kGreyColor,
            textColor: Colors.white,
            onPressed: widget.closePanel,
          ),
        ],
      ),
    );
  }
}
