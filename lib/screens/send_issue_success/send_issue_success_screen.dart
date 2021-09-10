import 'package:flutter/material.dart';
import 'package:haiya_client/screens/customer_service/customer_service_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import '../../constants.dart';

class SendIssueSuccessScreen extends StatelessWidget {
  static final routeName = '/send-issue-success';

  const SendIssueSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text(
              "Report Sent",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              "Our staff will reply to you\nwithin 3 days",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kDefaultPadding * 2),
            Image.asset(
              'assets/images/person_check.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: kDefaultPadding * 2),
            Text(
              "Thank you for reporting issues!",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: kGreyColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kDefaultPadding * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: CustomBtn(
                text: "GO BACK",
                boxColor: kPrimaryColor,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          CustomerServiceScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                textColor: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
