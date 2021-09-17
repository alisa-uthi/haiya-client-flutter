import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

import 'app_theme_option.dart';
import 'manage_notifications.dart';
import 'password_option.dart';

class SettingOptions extends StatelessWidget {
  const SettingOptions({
    Key? key,
    required this.onClickChangePass,
  }) : super(key: key);

  final Function onClickChangePass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordOption(onClickChangePass: onClickChangePass),
        SizedBox(height: kDefaultPadding),
        ManageNotifications(),
      ],
    );
  }
}
