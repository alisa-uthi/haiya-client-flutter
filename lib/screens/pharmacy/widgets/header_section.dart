import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required Pharmacy? pharmacy,
  })  : _pharmacy = pharmacy,
        super(key: key);

  final Pharmacy? _pharmacy;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: _pharmacy!.image,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: kDefaultPadding),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _pharmacy!.name,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tel: ${_pharmacy!.phone}',
                    style: TextStyle(color: kGreyColor),
                  ),
                  if (_pharmacy!.email != null && _pharmacy!.email != '')
                    Text(
                      'Email: ${_pharmacy!.email}',
                      style: TextStyle(color: kGreyColor),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
