import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class CustomerServiceScreen extends StatelessWidget {
  static final routeName = '/customer-service';
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text(
                "Customer Service",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
