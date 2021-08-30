import 'package:flutter/material.dart';

import '../../../constants.dart';

class SubmitOrderLoader extends StatelessWidget {
  const SubmitOrderLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: kDefaultPadding),
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: kPrimaryColor,
              color: kBackgroundColor,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            "Submitting Your Order...",
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
