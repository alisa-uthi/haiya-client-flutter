import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';

import '../../../constants.dart';
import 'pharmacy_card.dart';

class PharmacyList extends StatelessWidget {
  const PharmacyList({
    Key? key,
    required this.pharmacies,
    required this.itemCount,
  }) : super(key: key);

  final List<Pharmacy> pharmacies;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return pharmacies.length != 0
        ? GridView.builder(
            shrinkWrap: true,
            itemCount:
                pharmacies.length < itemCount ? pharmacies.length : itemCount,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPadding / 2,
              crossAxisSpacing: kDefaultPadding / 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return PharmacyCard(pharmacy: pharmacies[index]);
            },
          )
        : Center(
            child: Text("No Result Found."),
          );
  }
}
