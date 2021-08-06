import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/product.dart';

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
  String? _note;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: kGreyColor,
      ),
    );

    return Column(
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
    );
  }

  Widget _buildAddToCartBtn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add to Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.product.catalog.price * _quantity} THB",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
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
