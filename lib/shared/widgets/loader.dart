import 'package:flutter/material.dart';

import '../../constants.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding),
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: kPrimaryColor,
              color: kLightGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
