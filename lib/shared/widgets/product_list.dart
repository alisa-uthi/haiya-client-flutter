import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/product_card.dart';

import '../../constants.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPadding / 2,
        crossAxisSpacing: kDefaultPadding / 2,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
