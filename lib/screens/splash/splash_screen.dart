import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/authOption/auth_option_screen.dart';
import 'package:haiya_client/screens/signin/signin_screen.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = '/spash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthOptionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, AuthOptionScreen.routeName);
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Loader(),
            ],
          ),
        ),
      ),
    );
  }
}
