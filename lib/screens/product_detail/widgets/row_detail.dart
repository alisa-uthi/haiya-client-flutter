import 'package:flutter/material.dart';

class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,
    required this.title,
    this.detail = '',
    this.textColor = Colors.black,
  }) : super(key: key);

  final String title;
  final String detail;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            detail,
            overflow: TextOverflow.clip,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
