import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/widgets/pharmacy_card.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/constant_service.dart';

class NearestPharmacyList extends StatefulWidget {
  const NearestPharmacyList({Key? key}) : super(key: key);

  @override
  _NearestPharmacyListState createState() => _NearestPharmacyListState();
}

class _NearestPharmacyListState extends State<NearestPharmacyList> {
  List<Pharmacy> _nearestPharmacies = [];

  void initState() {
    setState(() {
      _nearestPharmacies = ConstantService.dummyPharmacies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 2,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: kDefaultPadding / 2,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return PharmacyCard(pharmacy: _nearestPharmacies[index]);
      },
    );
  }
}
