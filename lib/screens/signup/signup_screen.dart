import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signup/widgets/signup_form.dart';
import 'package:haiya_client/shared/widgets/avartar_image.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = '/signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign up",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please insert patient’s information",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: kDefaultPadding),
              AvartarImage(),
              SizedBox(height: kDefaultPadding),
              SignUpForm(),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
