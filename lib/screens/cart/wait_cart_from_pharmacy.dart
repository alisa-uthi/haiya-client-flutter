import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/cart/cart_screen.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

class WaitCartFromPharmacy extends StatefulWidget {
  const WaitCartFromPharmacy({Key? key}) : super(key: key);

  @override
  _WaitCartFromPharmacyState createState() => _WaitCartFromPharmacyState();
}

class _WaitCartFromPharmacyState extends State<WaitCartFromPharmacy> {
  bool _fetchStatus = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchCartFromPharmacy();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  Future _fetchCartFromPharmacy() async {
    OrderService orderService = new OrderService();
    _timer = new Timer.periodic(Duration(seconds: 5), (Timer t) async {
      _fetchStatus = await orderService.getCartFromPharmacy();
      if (_fetchStatus == true) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => CartScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
        _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 1.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Icon(
                Icons.add_shopping_cart,
                size: 100,
                color: kPrimaryColor,
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                "The pharmacist is adding the products to your cart\nDo not leave this page....",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Once the pharmacist finish adding products to your cart, you will be navigated to your updated cart.",
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Text(
                "If there is no product needed to add from the pharmacy, please press the button below.",
                style: TextStyle(color: kGreyColor),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              CustomBtn(
                text: "Go back",
                boxColor: kPrimaryColor,
                onPressed: () {
                  _timer!.cancel();
                  Navigator.pop(context);
                },
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
