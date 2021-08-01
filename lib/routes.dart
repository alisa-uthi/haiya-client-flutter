import 'package:flutter/material.dart';
import 'package:haiya_client/screens/authOption/auth_option_screen.dart';

import 'screens/signin/signin_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  AuthOptionScreen.routeName: (context) => AuthOptionScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
};
