import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signup/signup_screen.dart';
import 'package:haiya_client/shared/widgets/custom_alert_dialog.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class TermAgreementScreen extends StatefulWidget {
  static final routeName = '/term-agreement';

  const TermAgreementScreen({Key? key}) : super(key: key);

  @override
  _TermAgreementScreenState createState() => _TermAgreementScreenState();
}

class _TermAgreementScreenState extends State<TermAgreementScreen> {
  bool _isAgreeOnTerms = false;

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
              HeaderText(text: 'Terms & Conditions'),
              SizedBox(height: kDefaultPadding / 2),
              CustomCard(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Text(
                        """ 
              These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and [business entity name] (“we,” “us” or “our”), concerning your access to and use of the [website name.com] website as well as any other media form, media channel, mobile website or mobile application related, linked, or otherwise connected thereto (collectively, the “Site”).

              You agree that by accessing the Site, you have read, understood, and agree to be bound by all of these Terms and Conditions. If you do not agree with all of these Terms and Conditions, then you are expressly prohibited from using the Site and you must discontinue use immediately.
              """,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: kPrimaryColor,
                    value: _isAgreeOnTerms,
                    onChanged: (value) => setState(
                      () {
                        _isAgreeOnTerms = value!;
                      },
                    ),
                  ),
                  Text("I agree to HAIYA’s Term of services"),
                ],
              ),
              SizedBox(height: kDefaultPadding / 1.5),

              // Submit Button
              CustomBtn(
                text: "CONFIRM",
                boxColor: _isAgreeOnTerms ? kSuccessColor : kGreyColor,
                textColor: Colors.white,
                onPressed: () => {
                  if (_isAgreeOnTerms)
                    {Navigator.pushNamed(context, SignUpScreen.routeName)}
                },
              ),
              SizedBox(height: kDefaultPadding / 1.5),
            ],
          ),
        ),
      ),
    );
  }
}
