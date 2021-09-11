import 'package:flutter/material.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/widgets/product_list.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import '../../../constants.dart';

class ProductSection extends StatelessWidget {
  ProductSection({
    Key? key,
    required this.category,
    required this.pharmacy,
    required this.products,
  }) : super(key: key);

  final Category category;
  final Pharmacy pharmacy;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(
          title: 'Products',
          moreText: 'See more',
          onMoreTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    ProductListScreen(
                  category: category,
                  pharmacyId: pharmacy.id,
                  pharmacyName: pharmacy.name,
                ),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
        ),
        SizedBox(height: kDefaultPadding / 2),
        ProductList(products: products, itemCount: 4),
      ],
    );
  }
}
