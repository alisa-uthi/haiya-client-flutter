import 'package:flutter/material.dart';
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
        TextButton(
          onPressed: () {},
          child: Text(
            "EDIT",
            style: TextStyle(
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
