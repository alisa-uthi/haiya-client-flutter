import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/widgets/consultation_btn.dart';
import 'package:haiya_client/shared/widgets/custom_alert_dialog.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  int _quantity = 1;
  String _note = '';

  void _addToCart() {
    var product = widget.product;

    // Check if the product is already in the cart
    // If it is, add quantity
    var existingProductInCart =
        cart.firstWhereOrNull((item) => item.productName == product.tradeName);
    if (existingProductInCart != null) {
      int indexInCart = cart.indexOf(existingProductInCart);
      if (indexInCart != -1) {
        cart[indexInCart].quantity += _quantity;
        cart[indexInCart].totalCost += product.price;
      }
    } else {
      cart.add(new OrderLine(
        productId: product.id,
        productName: product.tradeName,
        productImage: product.image,
        productPrice: product.price,
        quantity: _quantity,
        totalCost: product.price * _quantity,
        comment: _note,
      ));
    }
    // Navigator.pop(context);
    // Get category of the product
    Category selectedCategory =
        allCategories.firstWhere((cat) => cat.name == product.category);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => ProductListScreen(
          category: selectedCategory,
          pharmacyId: product.pharmacyId,
          pharmacyName: product.pharmacyName,
        ),
        transitionDuration: Duration(seconds: 0),
      ),
    ).then((_) => setState(() {}));
  }

  void _onAddClicked() async {
    // Users are allowed to order from one pharmacy at a time
    if (cart.length == 0) {
      // Set selected pharmacy for the order
      selectedPharmacy = widget.product.pharmacyName;
      _addToCart();
    } else if (selectedPharmacy != widget.product.pharmacyName) {
      // Show dialog to warn user
      setState(() {});
      _showDialog();
    } else {
      _addToCart();
    }
  }

  Future _showDialog() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      CustomAlertDialog alert = CustomAlertDialog(
        title: "New Order Confirmation",
        content:
            "If you want to order from different pharmacy, Items from the previous pharmacy will be cancelled.",
        callBack: () => {
          cart.clear(),
          selectedPharmacy = widget.product.pharmacyName,
          _addToCart(),
          Navigator.pop(context),
        },
      );
      showDialog(context: context, builder: (BuildContext context) => alert);
    });
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: kGreyColor,
      ),
    );

    return widget.product.presReq == 'n' || widget.product.presReq == 'N'
        ? Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Additional Note",
                  labelStyle: Theme.of(context).textTheme.headline1,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                ),
                onChanged: (value) => setState(() => _note = value),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              _buildQuantitySection(context),
              SizedBox(height: kDefaultPadding * 3),
              _buildAddToCartBtn(),
            ],
          )
        : Center(
            child: ConsultationBtn(pharmacyName: widget.product.pharmacyName),
          );
  }

  Widget _buildAddToCartBtn() {
    const whiteText = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: _onAddClicked,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add to Cart", style: whiteText),
            Text("${widget.product.price * _quantity} THB", style: whiteText)
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _quantity--;

              if (_quantity <= 0) _quantity = 1;
            });
          },
          icon: Icon(
            Icons.remove_circle_outline,
            size: 50,
          ),
        ),
        SizedBox(width: kDefaultPadding),
        Text(
          _quantity.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(width: kDefaultPadding),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => setState(() => _quantity++),
          icon: Icon(
            Icons.add_circle_outline,
            size: 50,
          ),
        ),
      ],
    );
  }
}
