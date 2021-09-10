import 'package:flutter/material.dart';

import '../../../constants.dart';

class AppThemeOption extends StatefulWidget {
  const AppThemeOption({Key? key}) : super(key: key);

  @override
  _AppThemeOptionState createState() => _AppThemeOptionState();
}

class _AppThemeOptionState extends State<AppThemeOption> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "App Theme",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: kDefaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),
            Switch(
              value: _darkMode,
              activeColor: kPrimaryColor,
              activeTrackColor: kPrimaryColor.withOpacity(0.5),
              onChanged: (value) {
                setState(() => _darkMode = !_darkMode);
              },
            ),
          ],
        ),
      ],
    );
  }
}
