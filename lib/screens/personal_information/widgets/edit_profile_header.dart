import 'package:flutter/material.dart';
import 'package:haiya_client/screens/edit_personal_info/edit_personal_info_screen.dart';
import 'package:haiya_client/shared/widgets/profile_header.dart';

import '../../../constants.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeader(isViewOnly: true),
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      EditPersonalInfoScreen(),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            child: Text(
              "EDIT",
              style: TextStyle(
                color: kPrimaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
