import 'package:flutter/material.dart';

import 'screens/add_shipping_address/add_address_screen.dart';
import 'screens/authOption/auth_option_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/checkout_order/checkout_order_screen.dart';
import 'screens/checkout_success/checkout_success_screen.dart';
import 'screens/congenital_form/congenital_form_screen.dart';
import 'screens/customer_service/customer_service_screen.dart';
import 'screens/drug_allery_form/drug_allergy_form_screen.dart';
import 'screens/edit_personal_info/edit_personal_info_screen.dart';
import 'screens/faq/faq_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/operation_times/operation_times_screen.dart';
import 'screens/personal_information/personal_information_screen.dart';
import 'screens/pharmacy/pharmacy_screen.dart';
import 'screens/pharmacy_detail_list/phamacy_detail_list_screen.dart';
import 'screens/product_detail/product_detail_screen.dart';
import 'screens/product_list/product_list_screen.dart';
import 'screens/profile_navigation/profile_navigation_screen.dart';
import 'screens/purchase_history/purchase_history_screen.dart';
import 'screens/purchase_history_detail/purchase_history_detail_screen.dart';
import 'screens/report_issue/report_issue_screen.dart';
import 'screens/send_issue_success/send_issue_success_screen.dart';
import 'screens/settings/setting_screen.dart';
import 'screens/shipping_address/shipping_address_screen.dart';
import 'screens/signin/signin_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/signup_success/signup_success_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/term_agreement/term_agreement_screen.dart';
import 'screens/verify_otp/verify_otp_screen.dart';
import 'shared/models/category.dart';

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
  PharmacyScreen.routeName: (context) => PharmacyScreen(pharmacyId: 0),
  PharmacyDetailListScreen.routeName: (context) => PharmacyDetailListScreen(
        title: '',
        pharmacies: [],
      ),
  OperationTimesScreen.routeName: (context) =>
      OperationTimesScreen(pharmacy: null),
  ProductListScreen.routeName: (context) =>
      ProductListScreen(category: Category(id: -1, name: '')),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  CheckoutOrderScreen.routeName: (context) => CheckoutOrderScreen(),
  CheckoutSuccessScreen.routeName: (context) => CheckoutSuccessScreen(),
  ShippingAddressScreen.routeName: (context) => ShippingAddressScreen(),
  AddAddressScreen.routeName: (context) => AddAddressScreen(),
  ProfileNavigationScreen.routeName: (context) => ProfileNavigationScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  CustomerServiceScreen.routeName: (context) => CustomerServiceScreen(),
  PersonalInformationScreen.routeName: (context) => PersonalInformationScreen(),
  EditPersonalInfoScreen.routeName: (context) => EditPersonalInfoScreen(),
  PurchaseHistoryScreen.routeName: (context) => PurchaseHistoryScreen(),
  PurchaseHistoryDetailScreen.routeName: (context) =>
      PurchaseHistoryDetailScreen(orderId: 0),
  FaqScreen.routeName: (context) => FaqScreen(),
  ReportIssueScreen.routeName: (context) => ReportIssueScreen(),
  SendIssueSuccessScreen.routeName: (context) => SendIssueSuccessScreen(),
};
