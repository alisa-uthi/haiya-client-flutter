import 'package:flutter/material.dart';

import '../../constants.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
