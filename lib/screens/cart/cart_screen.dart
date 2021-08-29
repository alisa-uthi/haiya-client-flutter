import 'package:flutter/material.dart';

import '../../constants.dart';

class CartScreen extends StatelessWidget {
  static final routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "My Cart",
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Text("My cart ja"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
