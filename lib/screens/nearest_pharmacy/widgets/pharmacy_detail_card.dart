import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class PharmacyDetailCard extends StatelessWidget {
  const PharmacyDetailCard({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pharmacy.operationTime.isOpen
          ? () {
              // TODO: Navi,gate to product page
            }
          : () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        margin: const EdgeInsets.only(bottom: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding / 3),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pharmacy.name,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: !pharmacy.operationTime.isOpen
                            ? kGreyColor.withOpacity(0.5)
                            : Colors.black,
                      ),
                ),
                Text(
                  pharmacy.distanceFromCurrentLoc!,
                  style: TextStyle(
                    color: !pharmacy.operationTime.isOpen
                        ? kGreyColor.withOpacity(0.5)
                        : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding / 2),
            _buildOperationTime(),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationTime() {
    return Row(
      children: [
        Spacer(),
        Icon(
          Icons.access_time_filled,
          size: 30,
          color: !pharmacy.operationTime.isOpen
              ? kGreyColor.withOpacity(0.5)
              : Colors.black,
        ),
        SizedBox(width: kDefaultPadding / 2),
        Column(
          children: [
            Text(
              pharmacy.operationTime.openHr,
              style: TextStyle(
                color: !pharmacy.operationTime.isOpen
                    ? kGreyColor.withOpacity(0.5)
                    : Colors.black,
              ),
            ),
            Text(
              pharmacy.operationTime.closeHr,
              style: TextStyle(
                color: !pharmacy.operationTime.isOpen
                    ? kGreyColor.withOpacity(0.5)
                    : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
