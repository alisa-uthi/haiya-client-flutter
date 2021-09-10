import 'package:flutter/material.dart';
import 'package:haiya_client/screens/faq/faq_screen.dart';
import 'package:haiya_client/screens/report_issue/report_issue_screen.dart';
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
        SizedBox(height: kDefaultPadding * 1.2),
        _buildNavigateButton(context, FaqScreen()),
        SizedBox(height: kDefaultPadding * 2.5),

        // Report Issue
        HugeIcon(icon: Icons.flag),
        SizedBox(height: kDefaultPadding),
        Text(
          "Report Issues",
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: kDefaultPadding * 1.2),
        _buildNavigateButton(context, ReportIssueScreen()),
      ],
    );
  }

  CustomBtn _buildNavigateButton(BuildContext context, Widget screen) {
    return CustomBtn(
      text: "TAB HERE",
      boxColor: kPrimaryColor,
      onPressed: () => _navigateTo(context, screen),
      textColor: Colors.white,
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => screen,
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
}
