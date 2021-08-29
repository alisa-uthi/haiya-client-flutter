import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/widgets/shopping_cart_icon.dart';

import 'widgets/detail_container.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-detail';

  const ProductDetailScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  final Product? product;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Product Details",
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      actions: [
        ShoppingCartBtn(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: kDefaultPadding * 1.5),
                CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: product!.image,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                SizedBox(height: kDefaultPadding * 1.5),
                DetailContainer(product: product),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
