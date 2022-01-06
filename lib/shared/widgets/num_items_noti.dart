import 'package:flutter/material.dart';

import '../../constants.dart';

class NumItemsNoti extends StatelessWidget {
  const NumItemsNoti({
    Key? key,
    required this.notiFor,
  }) : super(key: key);

  final List<dynamic> notiFor;

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
            notiFor.length > 9 ? "10+" : notiFor.length.toString(),
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
