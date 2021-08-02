import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: double.infinity),
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding / 3),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
