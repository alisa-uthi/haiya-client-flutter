import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/product.dart';

import '../../../constants.dart';
import 'product_detail.dart';

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding * 2),
          topRight: Radius.circular(kDefaultPadding * 2),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kGreyColor.withOpacity(0.5),
            blurRadius: 15,
          ),
        ],
      ),
      child: ProductDetail(product: product),
    );
  }
}
