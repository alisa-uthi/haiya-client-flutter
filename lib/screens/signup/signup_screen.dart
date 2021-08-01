import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signup/widgets/signup_form.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: Icon(Icons.camera_alt),
          ),
        ],
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
              SignUpForm()
            ],
          ),
        ),
      ),
    );
  }
}
