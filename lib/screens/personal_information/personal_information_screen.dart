import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/personal_information/widgets/profile_info.dart';

import 'widgets/edit_profile_header.dart';

class PersonalInformationScreen extends StatelessWidget {
  static final routeName = '/personal-information';
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: kDefaultPadding),
                EditProfileHeader(),
                SizedBox(height: kDefaultPadding / 2),
                ProfileInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
