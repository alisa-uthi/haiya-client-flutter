import 'package:flutter/material.dart';
import 'package:haiya_client/screens/product_detail/widgets/order_form.dart';
import 'package:haiya_client/screens/product_detail/widgets/row_detail.dart';
import 'package:haiya_client/shared/models/product.dart';

import '../../../constants.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product!.tradeName,
          style: Theme.of(context).textTheme.headline1,
          overflow: TextOverflow.clip,
        ),
        SizedBox(height: kDefaultPadding / 2),
        Text(
          "${product!.catalog.pharmacyName}",
          style: Theme.of(context).textTheme.bodyText1,
        ),

        // Generic Name
        SizedBox(height: kDefaultPadding * 2),
        product!.genericName != null
            ? RowDetail(
                title: "Generic Name",
                detail: product!.genericName![0].genericName,
              )
            : Container(),
        SizedBox(height: kDefaultPadding / 1.3),

        // Company Name
        product!.companyName != null
            ? RowDetail(
                title: "Company",
                detail: product!.companyName ?? '',
              )
            : Container(),
        SizedBox(height: kDefaultPadding / 1.3),

        // Detail
        RowDetail(title: "Detail", detail: product!.detail),
        SizedBox(height: kDefaultPadding / 1.3),

        // Generic Advice
        product!.genericAdvice != null
            ? RowDetail(title: "Advice", detail: product!.genericAdvice ?? '')
            : Container(),
        SizedBox(height: kDefaultPadding * 3),

        OrderForm(product: product!),
      ],
    );
  }
}
