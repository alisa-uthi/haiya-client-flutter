import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  static final routeName = '/purchase-history';
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text(
                "Purchase History",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
