import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import '../../../constants.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({
    Key? key,
    required this.address,
  }) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: "Address",
          moreText: "View Map",
          onMoreTap: () {},
        ),
        SizedBox(height: kDefaultPadding / 2),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Text(address.location),
          ),
        ),
      ],
    );
  }
}
