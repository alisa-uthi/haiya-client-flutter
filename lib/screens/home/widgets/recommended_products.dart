import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/widgets/product_list.dart';

class RecommendedProductsSection extends StatefulWidget {
  const RecommendedProductsSection({Key? key}) : super(key: key);

  @override
  _RecommendedProductsSectionState createState() =>
      _RecommendedProductsSectionState();
}

class _RecommendedProductsSectionState
    extends State<RecommendedProductsSection> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _products = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductList(products: _products, itemCount: 6);
  }
}
