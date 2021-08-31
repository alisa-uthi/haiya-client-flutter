import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/purchase_history/widgets/purchase_history_list.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  static final routeName = '/purchase-history';
  const PurchaseHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Purchase History",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: kDefaultPadding),
              PurchaseHistoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
