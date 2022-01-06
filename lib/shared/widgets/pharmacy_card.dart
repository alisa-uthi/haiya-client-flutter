import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/screens/ask_prescription/ask_prescription.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (buider, animation1, animation2) => ProductListScreen(
        //       category: allCategories[0],
        //       pharmacyId: pharmacy.id,
        //       pharmacyName: pharmacy.name,
        //     ),
        //   ),
        // );
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (buider, animation1, animation2) =>
                AskPrescriptionScreen(
              pharmacyId: pharmacy.id,
              pharmacyName: pharmacy.name,
            ),
          ),
        );
      },
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                width: 150,
                height: 100,
                imageUrl: pharmacy.image,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Spacer(),
            Text(
              pharmacy.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              pharmacy.address!.location,
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.clip,
              maxLines: 3,
            ),
            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
