import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/widgets/product_card.dart';

import '../../constants.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
    required this.itemCount,
  }) : super(key: key);

  final List<Product> products;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return products.length != 0
        ? GridView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
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
          )
        : Center(
            child: Text("No Result Found."),
          );
  }
}
