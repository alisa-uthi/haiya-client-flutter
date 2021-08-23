import 'package:flutter/material.dart';

import 'screens/authOption/auth_option_screen.dart';
import 'screens/congenital_form/congenital_form_screen.dart';
import 'screens/drug_allery_form/drug_allergy_form_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/nearest_pharmacy/nearest_phamacy_screen.dart';
import 'screens/product_detail/product_detail_screen.dart';
import 'screens/product_list/product_list_screen.dart';
import 'screens/signin/signin_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/signup_success/signup_success_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/term_agreement/term_agreement_screen.dart';
import 'screens/verify_otp/verify_otp_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  AuthOptionScreen.routeName: (context) => AuthOptionScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  TermAgreementScreen.routeName: (context) => TermAgreementScreen(),
  VerifyOtpScreen.routeName: (context) => VerifyOtpScreen(),
  SignupSuccessScreen.routeName: (context) => SignupSuccessScreen(),
  CongenitalFormScreen.routeName: (context) => CongenitalFormScreen(),
  DrugAllergyFormScreen.routeName: (context) => DrugAllergyFormScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  NearestPharmacyScreen.routeName: (context) => NearestPharmacyScreen(),
  ProductListScreen.routeName: (context) => ProductListScreen(category: ''),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
};
