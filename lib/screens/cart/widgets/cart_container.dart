import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/title_with_price.dart';

import 'cart_item.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({
    Key? key,
    required this.rebuildEmptyCart,
  }) : super(key: key);

  final Function rebuildEmptyCart;

  @override
  _CartContainerState createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  ValueNotifier<List<OrderLine>> _cart = ValueNotifier(cart);
  int _orderTotalPrice = 0;

  void computeTotalPrice() {
    int totalPrice = 0;
    for (var orderLine in cart) {
      print(orderLine.totalCost);
      totalPrice += orderLine.totalCost;
    }
    setState(() => _orderTotalPrice = totalPrice);

    checkEmptyOrder();
  }

  void checkEmptyOrder() {
    if (cart.length == 0) {
      widget.rebuildEmptyCart();
    }
  }

  @override
  void initState() {
    super.initState();
    computeTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _cart,
      builder: (context, value, child) {
        return Column(
          children: [
            _buildCartItemList(),
            SizedBox(height: kDefaultPadding),
            Divider(color: Colors.white),
            SizedBox(height: kDefaultPadding / 2),
            TitleWithPrice(title: 'Total', price: _orderTotalPrice),
            SizedBox(height: kDefaultPadding),
            TitleWithPrice(title: 'Delivery Fee', price: 30),
            SizedBox(height: kDefaultPadding * 1.7),
            CustomBtn(
              text: "CHECKOUT",
              boxColor: kPrimaryColor,
              onPressed: () {},
              textColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  Widget _buildCartItemList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: cart.length,
          itemBuilder: (context, index) {
            var cartItem = cart[index];
            return CartItem(
              cartItem: cartItem,
              removeItem: (orderLine) {
                cart.remove(orderLine);
                computeTotalPrice();
                _cart.notifyListeners();
              },
              onQuantityChange: (changedQuantity) {
                cartItem.quantity = changedQuantity;
                cartItem.totalCost = cartItem.productPrice! * cartItem.quantity;
                computeTotalPrice();
                _cart.notifyListeners();
              },
            );
          }),
    );
  }
}
