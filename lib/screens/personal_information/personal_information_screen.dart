import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class PersonalInformationScreen extends StatelessWidget {
  static final routeName = '/personal-information';
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text(
                "Personal Information",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
