import 'package:flutter/material.dart';

import '../../../constants.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 2,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(width: kDefaultPadding / 2),
        Text(
          "OR",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: kDefaultPadding / 2),
        Expanded(
          child: Divider(
            thickness: 2,
            color: kPrimaryColor,
          ),
        ),
      ]),
    );
  }
}
