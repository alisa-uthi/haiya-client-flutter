import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

import '../../constants.dart';
import 'widgets/cart_container.dart';
import 'widgets/empty_cart.dart';

class CartScreen extends StatefulWidget {
  static final routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ValueNotifier<List<OrderLine>> _cart = ValueNotifier(cart);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: cart.length != 0 ? true : false,
      ),
      body: _buildTitleBar(context),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _cart,
        builder: (context, child, value) {
          return cart.length != 0 ? _buildCart(size) : _buildEmptyCart();
        },
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
        ),
        child: Text(
          "My Cart",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  Widget _buildCart(Size size) {
    return Container(
      width: size.width,
      height: size.height / 1.25,
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 2,
        horizontal: kDefaultPadding * 1.5,
      ),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding * 2),
          topRight: Radius.circular(kDefaultPadding * 2),
        ),
      ),
      child: CartContainer(
        rebuildEmptyCart: () => _cart.notifyListeners(),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        EmptyCart(),
        Spacer(),
        BottomNavBar(index: 1),
      ],
    );
  }
}
