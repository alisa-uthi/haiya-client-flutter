import 'package:flutter/material.dart';

class TitleWithPrice extends StatelessWidget {
  const TitleWithPrice({
    Key? key,
    required this.title,
    required this.price,
    required this.color,
  }) : super(key: key);

  final String title;
  final int price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: color),
        ),
        Text(
          "${price} THB",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: color),
        ),
      ],
    );
  }
}
