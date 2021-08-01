import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = '/signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Sign up page"),
      ),
    );
  }
}
