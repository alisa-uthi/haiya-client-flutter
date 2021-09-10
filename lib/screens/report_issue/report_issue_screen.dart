import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

import '../../constants.dart';
import 'widgets/issue_form.dart';

class ReportIssueScreen extends StatelessWidget {
  static final routeName = '/report-issue';

  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: BottomNavBar(index: 3),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Service",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                "Report Issues",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: kDefaultPadding),
              IssueForm(),
            ],
          ),
        ),
      ),
    );
  }
}
