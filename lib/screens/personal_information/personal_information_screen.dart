import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/personal_information/widgets/profile_info.dart';
import 'package:haiya_client/screens/profile_navigation/profile_navigation_screen.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';

import 'widgets/edit_profile_header.dart';

class PersonalInformationScreen extends StatelessWidget {
  static final routeName = '/personal-information';
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProfileNavigationScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(text: "Personal Information"),
                  EditProfileHeader(),
                  SizedBox(height: kDefaultPadding / 2),
                  ProfileInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
