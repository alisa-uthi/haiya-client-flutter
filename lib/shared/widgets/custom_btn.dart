import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Color boxColor;
  final Color textColor;
  final Function onPressed;
  final bool? isBorder;

  const CustomBtn({
    Key? key,
    required this.text,
    required this.boxColor,
    required this.onPressed,
    required this.textColor,
    this.isBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(kDefaultPadding),
            border:
                isBorder! ? Border.all(color: Colors.black, width: 2) : null),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}
