import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';

import '../../../constants.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.cartItem,
    required this.removeItem,
    required this.onQuantityChange,
  }) : super(key: key);

  final OrderLine cartItem;
  final Function removeItem;
  final Function onQuantityChange;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    setState(() => _quantity = widget.cartItem.quantity);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleChange(int changedQuantity) {
    widget.onQuantityChange(changedQuantity);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> totalPrice = ValueNotifier(
        (widget.cartItem.productPrice! * widget.cartItem.quantity));

    var whiteText =
        Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white);

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultPadding / 2),
              child: Center(
                child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl: widget.cartItem.productImage!,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding / 1.5),

            // Item detail
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.productName,
                    style: whiteText,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Text(
                    '${totalPrice.value} THB',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(width: kDefaultPadding / 2),

            // Quantity
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(Icons.remove, 15, () {
                    setState(() {
                      _quantity--;
                    });
                    if (_quantity <= 0) {
                      setState(() {
                        _quantity = 1;
                      });
                    }
                    _handleChange(_quantity);
                  }),
                  Text(_quantity.toString(), style: whiteText),
                  _buildIconButton(Icons.add, 15, () {
                    setState(() => _quantity++);
                    _handleChange(_quantity);
                  }),
                ],
              ),
            ),
            SizedBox(width: kDefaultPadding),

            // Remove item button
            _buildIconButton(Icons.delete, 25, () {
              widget.removeItem(widget.cartItem);
            })
          ],
        ),
      ),
    );
  }

  IconButton _buildIconButton(
    IconData icon,
    double size,
    Function()? onPressed,
  ) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
