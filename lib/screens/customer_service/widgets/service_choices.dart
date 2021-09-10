import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../../constants.dart';
import 'huge_icon.dart';

class ServiceChoices extends StatelessWidget {
  const ServiceChoices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FAQ
        HugeIcon(icon: Icons.question_answer),
        SizedBox(height: kDefaultPadding),
        Text(
          "Frequently Asked Questions",
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: kDefaultPadding * 1.5),
        _buildNavigateButton(() {}),
        SizedBox(height: kDefaultPadding * 3),

        // Report Issue
        HugeIcon(icon: Icons.flag),
        SizedBox(height: kDefaultPadding),
        Text(
          "Report Issues",
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: kDefaultPadding * 1.5),
        _buildNavigateButton(() {}),
      ],
    );
  }

  CustomBtn _buildNavigateButton(Function onPressed) {
    return CustomBtn(
      text: "TAB HERE",
      boxColor: kPrimaryColor,
      onPressed: onPressed,
      textColor: Colors.white,
    );
  }
}
