import 'package:flutter/material.dart';

import '../../constants.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    required this.title,
    required this.moreText,
    required this.onMoreTap,
  }) : super(key: key);

  final String title;
  final String moreText;
  final Function onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline1),
        GestureDetector(
          onTap: () => onMoreTap(),
          child: Text(
            moreText,
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
