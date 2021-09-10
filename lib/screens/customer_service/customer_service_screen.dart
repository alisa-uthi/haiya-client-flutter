import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import 'widgets/service_choices.dart';

class CustomerServiceScreen extends StatelessWidget {
  static final routeName = '/customer-service';
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: BottomNavBar(index: 3),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Service",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding * 2),
              ServiceChoices(),
            ],
          ),
        ),
      ),
    );
  }
}
