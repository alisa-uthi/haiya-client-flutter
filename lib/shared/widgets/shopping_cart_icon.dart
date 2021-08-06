import 'package:flutter/material.dart';

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
        onPressed: () {},
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
