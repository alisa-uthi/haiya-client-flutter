import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

class SignupSuccessScreen extends StatelessWidget {
  static final routeName = '/signup-success';

  const SignupSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Spacer(),
              HeaderText(text: "Registration Complete"),
              SizedBox(height: kDefaultPadding),
              Text("Welcome to"),
              Spacer(),
              Image.asset(
                'assets/images/haiya_logo.png',
                width: 270,
                height: 270,
              ),
              Text(
                "HAIYA",
                style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              Spacer(),
              CustomBtn(
                text: "CLICK HERE TO CONTINUE",
                boxColor: kPrimaryColor,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomeScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                    (route) => false,
                  );
                },
                textColor: Colors.white,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
