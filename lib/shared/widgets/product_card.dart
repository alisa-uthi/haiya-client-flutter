import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:haiya_client/screens/product_detail/product_detail_screen.dart';
import 'package:haiya_client/shared/models/product.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ProductDetailScreen(product: widget.product),
            transitionDuration: Duration(seconds: 0),
          ),
        ).then((_) => setState(() {}));
      },
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: CachedNetworkImage(
                width: 120,
                height: 120,
                imageUrl: widget.product.image,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Spacer(),

            // Pharmacy Name
            Text(
              widget.product.pharmacyName,
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: kDefaultPadding / 2),

            // Product's Trade Name
            Text(
              widget.product.tradeName,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            SizedBox(height: kDefaultPadding / 2),

            // Price
            Text(
              '${widget.product.price.toString()} THB',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
