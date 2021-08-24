import 'package:flutter/material.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class CurrentLocationTap extends StatelessWidget {
  const CurrentLocationTap({
    Key? key,
    required String location,
  })  : _location = location,
        super(key: key);

  final String _location;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 35,
            color: kPrimaryColor,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Text(
              _location,
              overflow: TextOverflow.clip,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
