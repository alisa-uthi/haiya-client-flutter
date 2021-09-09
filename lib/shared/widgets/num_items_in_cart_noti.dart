import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';

import '../../constants.dart';

class NumItemsInCartNoti extends StatelessWidget {
  const NumItemsInCartNoti({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: kSecondaryColor),
          child: Text(
            cart.length > 9 ? "10+" : cart.length.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
