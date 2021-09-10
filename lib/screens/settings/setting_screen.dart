import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

import 'widgets/setting_options.dart';

class SettingScreen extends StatelessWidget {
  static final routeName = '/settings';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding),
              SettingOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
