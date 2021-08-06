import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,
    required this.title,
    this.detail = '',
  }) : super(key: key);

  final String title;
  final String detail;

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
          ),
        ),
      ],
    );
  }
}
