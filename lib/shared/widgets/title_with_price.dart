import 'package:flutter/material.dart';

class TitleWithPrice extends StatelessWidget {
  const TitleWithPrice({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String title;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
        Text(
          "${price} THB",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
