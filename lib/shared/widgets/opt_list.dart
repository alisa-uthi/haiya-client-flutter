import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/operation_time.dart';

import 'opt_detail_row.dart';

class OptList extends StatelessWidget {
  const OptList({
    Key? key,
    required this.operationTime,
  }) : super(key: key);

  final List<OperationTime>? operationTime;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: operationTime!.length,
      itemBuilder: (context, index) {
        var opt = operationTime![index];
        return OptDetailRow(opt: opt);
      },
    );
  }
}
