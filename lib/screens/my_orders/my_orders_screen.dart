import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

import 'widgets/approved_orders.dart';
import 'widgets/delivering_orders.dart';
import 'widgets/purchase_history.dart';

class MyOrdersScreen extends StatelessWidget {
  static final routeName = '/my-orders';

  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: kPrimaryColor,
            indicatorColor: kPrimaryColor,
            unselectedLabelColor: kGreyColor,
            tabs: [
              Tab(text: "Approved"),
              Tab(text: "Delivering"),
              Tab(text: "Completed"),
            ],
          ),
          title: Text(
            'My Orders',
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            ApprovedOrders(),
            DeliveringOrders(),
            PurchaseHistory(),
          ],
        ),
      ),
    );
  }
}
