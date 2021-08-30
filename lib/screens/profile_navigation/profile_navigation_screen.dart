import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/signin/signin_screen.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/profile_header.dart';

import 'widgets/navigation_list.dart';

class ProfileNavigationScreen extends StatelessWidget {
  static final routeName = '/profile-navigation';

  const ProfileNavigationScreen({Key? key}) : super(key: key);

  void _onLogout(BuildContext context) {
    // Reset every global variables
    currentUser = new UserDetail(
      id: 0,
      email: '',
      password: '',
      title: 'Mr.',
      firstname: '',
      lastname: '',
      gender: 'M',
      height: 0,
      weight: 0,
      phone: '',
      dob: '',
      image: '',
      congenitalDisease: [],
      drugAllergy: [],
    );
    userAddress = [];
    cart = [];
    selectedPharmacy = '';

    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.routeName,
      (route) => false,
    );
  }

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
              CustomBtn(
                text: "LOGOUT",
                boxColor: kPrimaryColor,
                onPressed: () => _onLogout(context),
                textColor: Colors.white,
              ),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
