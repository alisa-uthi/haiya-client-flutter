import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/provider/request_consult_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'constants.dart';
import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'shared/helper/firebase_messaging.dart';
import 'shared/provider/chat_provider.dart';
import 'shared/services/user_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseMessagingHelper().initilizeMessagingAndNotification();
  UserService userService = new UserService();
  latlng = await userService.getCurrentCoordinates();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<RequestConsulProvider>(
          create: (_) => RequestConsulProvider(
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5)),
        ),
        title: 'HAIYA',
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: themeData.copyWith(
          textTheme:
              GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).copyWith(
            headline1: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyText1: TextStyle(fontSize: 18, color: Colors.black),
            bodyText2: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
