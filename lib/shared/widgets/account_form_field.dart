import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

import '../../constants.dart';

class AccountFields {
  static Column buildEmailField(
      BuildContext context, Function(String) onChange) {
    final node = FocusScope.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey[700],
              ),
        ),
        SizedBox(height: kDefaultPadding / 2.5),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          initialValue: currentUser == null ? '' : currentUser.email,
          decoration: inputDecoration.copyWith(hintText: "Email"),
          validator: (value) {
            if (value!.isEmpty) {
              return kEmailNullError;
            }
            if (!emailPattern.hasMatch(value)) {
              return kInvalidEmailError;
            }
            return null;
          },
          onChanged: onChange,
          onEditingComplete: () => node.nextFocus(),
        ),
      ],
    );
  }

  static Column buildPasswordField(
      BuildContext context, Function(String) onChange, bool needConfirm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey[700],
              ),
        ),
        SizedBox(height: kDefaultPadding / 2.5),
        TextFormField(
          obscureText: true,
          textInputAction: needConfirm ? TextInputAction.next : null,
          decoration: inputDecoration.copyWith(hintText: "Password"),
          validator: (value) {
            if (value!.isEmpty) {
              return kPassNullError;
            }
            if (value.length < 8) {
              return kShortPassError;
            }
            return null;
          },
          onChanged: onChange,
        ),
      ],
    );
  }

  static Column buildConfirmedPasswordField(BuildContext context,
      Function(String) onChange, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Password",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.grey[700],
              ),
        ),
        SizedBox(height: kDefaultPadding / 2.5),
        TextFormField(
          obscureText: true,
          decoration: inputDecoration.copyWith(hintText: "Confirm Password"),
          validator: validator,
          onChanged: onChange,
        ),
      ],
    );
  }
}
