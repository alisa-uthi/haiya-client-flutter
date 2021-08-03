import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [Text("HOME")],
          ),
        ),
      ),
    );
  }
}
