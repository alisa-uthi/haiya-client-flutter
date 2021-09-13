import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/operation_time.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/opt_list.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import '../../../constants.dart';

class OperationTimeSection extends StatelessWidget {
  const OperationTimeSection({
    Key? key,
    required this.operationTime,
  }) : super(key: key);

  final List<OperationTime> operationTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: "Operation Time",
          moreText: '',
          onMoreTap: () {},
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding / 2,
              bottom: kDefaultPadding / 2,
            ),
            child: OptList(operationTime: operationTime),
          ),
        ),
      ],
    );
  }
}
