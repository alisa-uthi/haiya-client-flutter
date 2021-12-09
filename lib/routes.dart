import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/address.dart';

import 'screens/add_shipping_address/add_address_screen.dart';
import 'screens/authOption/auth_option_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/chat/widgets/full_photo.dart';
import 'screens/checkout_order/checkout_order_screen.dart';
import 'screens/checkout_success/checkout_success_screen.dart';
import 'screens/congenital_form/congenital_form_screen.dart';
import 'screens/consultation/consultation_video_screen.dart';
import 'screens/customer_service/customer_service_screen.dart';
import 'screens/delivery_tracking/delivery_tracking_screen.dart';
import 'screens/drug_allery_form/drug_allergy_form_screen.dart';
import 'screens/edit_personal_info/edit_personal_info_screen.dart';
import 'screens/faq/faq_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/my_orders/my_orders_screen.dart';
import 'screens/notification/notification_screen.dart';
import 'screens/operation_times/operation_times_screen.dart';
import 'screens/order_detail/order_detail_screen.dart';
import 'screens/personal_information/personal_information_screen.dart';
import 'screens/pharmacy/pharmacy_screen.dart';
import 'screens/pharmacy_address_maps/pharmacy_address_maps_screen.dart';
import 'screens/pharmacy_detail_list/phamacy_detail_list_screen.dart';
import 'screens/product_detail/product_detail_screen.dart';
import 'screens/product_list/product_list_screen.dart';
import 'screens/profile_navigation/profile_navigation_screen.dart';
import 'screens/rate_pharmacy/rate_pharmacy_screen.dart';
import 'screens/ratings/rating_screen.dart';
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
  OrderDetailScreen.routeName: (context) => OrderDetailScreen(orderId: 0),
  FaqScreen.routeName: (context) => FaqScreen(),
  ReportIssueScreen.routeName: (context) => ReportIssueScreen(),
  SendIssueSuccessScreen.routeName: (context) => SendIssueSuccessScreen(),
  RatingScreen.routeName: (context) => RatingScreen(
        ratings: [],
        pharmacyName: '',
      ),
  DeliveryTrackingScreen.routeName: (context) =>
      DeliveryTrackingScreen(orderId: 0),
  RatePharmacyScreen.routeName: (context) =>
      RatePharmacyScreen(pharmacyName: ''),
  MyOrdersScreen.routeName: (context) => MyOrdersScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  ConsultationVideoScreen.routeName: (context) =>
      ConsultationVideoScreen(pharmacyName: ""),
  PharmacyAddressMapsScreen.routeName: (context) => PharmacyAddressMapsScreen(
        pharmacyName: '',
        address: new Address(
          id: 0,
          name: '',
          location: '',
          isDeliveryAddress: '',
        ),
      ),
  ChatScreen.routeName: (context) => ChatScreen(
        peerAvatar: '',
        peerId: 0,
        peerNickname: '',
      ),
  FullPhotoScreen.routeName: (context) => FullPhotoScreen(url: ''),
};
