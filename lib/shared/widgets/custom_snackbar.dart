import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static buildSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        content: Text(message),
      ),
    );
  }
}
