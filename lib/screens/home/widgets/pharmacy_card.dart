import 'package:flutter/material.dart';
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (buider, animation1, animation2) => ProductListScreen(
              category: Category(id: 1, name: 'Drug'),
              pharmacy: pharmacy.id,
            ),
          ),
        );
      },
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/haiya_logo.png', // TODO: Change picture
                width: 120,
                height: 120,
              ),
            ),
            Spacer(),
            Text(
              pharmacy.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              pharmacy.address.toString(),
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
