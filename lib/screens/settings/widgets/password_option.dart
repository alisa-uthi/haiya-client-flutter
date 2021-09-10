import 'package:flutter/material.dart';

import '../../../constants.dart';

class PasswordOption extends StatelessWidget {
  const PasswordOption({
    Key? key,
  }) : super(key: key);

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
          onPressed: () {},
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
