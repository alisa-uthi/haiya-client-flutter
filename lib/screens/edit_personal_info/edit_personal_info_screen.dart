import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/edit_personal_info/widgets/personal_info_form.dart';
import 'package:haiya_client/shared/widgets/profile_header.dart';

class EditPersonalInfoScreen extends StatelessWidget {
  static final routeName = '/edit-personal-information';
  const EditPersonalInfoScreen({Key? key}) : super(key: key);

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
                ProfileHeader(isViewOnly: false),
                SizedBox(height: kDefaultPadding / 2),
                PersonalInfoForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
