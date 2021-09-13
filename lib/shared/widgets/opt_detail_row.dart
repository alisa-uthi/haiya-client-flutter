import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/operation_time.dart';

import '../../../constants.dart';

class OptDetailRow extends StatelessWidget {
  const OptDetailRow({
    Key? key,
    required this.opt,
  }) : super(key: key);

  final OperationTime opt;

  String _getTimePeriodUnit(String time) {
    if (int.parse(time.substring(0, 2)) < 12) {
      return 'AM';
    }
    return 'PM';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding / 1.5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('${opt.optDay}.'),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '${opt.openHr} ${_getTimePeriodUnit(opt.openHr)} - ${opt.closeHr} ${_getTimePeriodUnit(opt.closeHr)}',
            ),
          ),
        ],
      ),
    );
  }
}
