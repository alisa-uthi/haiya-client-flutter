import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

import '../../constants.dart';
import 'avartar_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.isViewOnly,
  }) : super(key: key);

  final bool isViewOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AvartarImage(isViewOnly: isViewOnly),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${currentUser.firstname} ${currentUser.lastname}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: kDefaultPadding / 2.5),
            Text(
              '${currentUser.email}',
              style: TextStyle(color: kGreyColor),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
