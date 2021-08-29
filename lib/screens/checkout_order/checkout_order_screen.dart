import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class CheckoutOrderScreen extends StatelessWidget {
  static final routeName = '/checkout';

  const CheckoutOrderScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Checkout',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Text("Checkout screen"),
            ],
          ),
        ),
      ),
    );
  }
}
