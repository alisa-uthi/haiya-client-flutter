import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/pharmacy_card.dart';

class NearestPharmacyList extends StatefulWidget {
  const NearestPharmacyList({Key? key}) : super(key: key);

  @override
  _NearestPharmacyListState createState() => _NearestPharmacyListState();
}

class _NearestPharmacyListState extends State<NearestPharmacyList> {
  @override
  Widget build(BuildContext context) {
    return nearestPharmacies.length > 0
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: kDefaultPadding / 2,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return PharmacyCard(pharmacy: nearestPharmacies[index]);
            },
          )
        : Center(
            child: Text("There is no pharmacy within 10 kilometers."),
          );
  }
}
