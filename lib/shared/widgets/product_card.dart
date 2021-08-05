import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/constant_service.dart';

import '../../constants.dart';
import 'custom_card.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String pharmacyName = '';

  @override
  void initState() {
    super.initState();
    // Get pharmacy of this product based on catalog -> pharmacyId
    setState(() {
      pharmacyName = ConstantService.dummyPharmacies()
          .firstWhere(
              (pharmacy) => pharmacy.id == widget.product.catalog.pharmacyId)
          .name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
            pharmacyName,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            widget.product.tradeName,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            '${widget.product.catalog.price.toString()} THB',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
