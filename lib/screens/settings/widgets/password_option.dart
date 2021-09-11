import 'package:flutter/material.dart';

import '../../../constants.dart';

class PasswordOption extends StatelessWidget {
  const PasswordOption({
    Key? key,
    required this.onClickChangePass,
  }) : super(key: key);

  final Function onClickChangePass;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Password",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TextButton(
          onPressed: () => onClickChangePass(),
          child: Text(
            "Change",
            style: TextStyle(
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
