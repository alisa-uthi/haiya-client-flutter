import 'package:flutter/material.dart';
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
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                widget.product.image,
                width: 120,
                height: 120,
              ),
            ),
            Spacer(),

            // Pharmacy Name
            widget.product.pharmacyName != null
                ? Text(
                    widget.product.pharmacyName!,
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.ellipsis,
                  )
                : Container(),
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
