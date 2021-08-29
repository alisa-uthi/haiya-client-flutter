import 'package:flutter/material.dart';

import '../../../constants.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_bag, size: 50, color: kPrimaryColor),
        SizedBox(height: kDefaultPadding),
        Text(
          "Cart is empty.",
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
