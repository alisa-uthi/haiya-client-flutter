import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/profile_header.dart';

import 'widgets/navigation_list.dart';

class ProfileNavigationScreen extends StatelessWidget {
  static final routeName = '/profile-navigation';

  const ProfileNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 3),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding),
              ProfileHeader(isViewOnly: true),
              SizedBox(height: kDefaultPadding),
              NavigationList(),
            ],
          ),
        ),
      ),
    );
  }
}
