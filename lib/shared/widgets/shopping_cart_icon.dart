import 'package:flutter/material.dart';
import 'package:haiya_client/screens/cart/cart_screen.dart';

import '../../constants.dart';

class ShoppingCartBtn extends StatelessWidget {
  const ShoppingCartBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 40,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => CartScreen(),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        },
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
