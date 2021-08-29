import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/checkout_success/checkout_success_screen.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';

import 'widgets/order_summary_section.dart';
import 'widgets/shipping_address_section.dart';

class CheckoutOrderScreen extends StatefulWidget {
  static final routeName = '/checkout';

  const CheckoutOrderScreen({Key? key}) : super(key: key);

  @override
  _CheckoutOrderScreenState createState() => _CheckoutOrderScreenState();
}

class _CheckoutOrderScreenState extends State<CheckoutOrderScreen> {
  UserService _userService = new UserService();
  OrderService _orderService = new OrderService();

  String _location = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<dynamic> _fetchCurrentLocation() async {
    String result = await _userService.getCurrentLocation();
    setState(() => {
          _location = result,
          _isLoading = false,
        });
  }

  Future<void> _submitOrder() async {
    bool isSuccess = await _orderService.createOrder(
      deliveryAddress: _location,
      deliveryPrice: 30,
      comment: '',
      pharmacy: selectedPharmacy,
    );

    if (isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              CheckoutSuccessScreen(),
          transitionDuration: Duration(seconds: 0),
        ),
        ModalRoute.withName(HomeScreen.routeName),
      );
    } else {
      CustomSnackBar.buildSnackbar(
        context,
        'Unable to checkout your order. Please try again.',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              !_isLoading
                  ? ShippingAddressSection(
                      deliveryAddress: _location,
                    )
                  : _buildLoadingText(context),
              SizedBox(height: kDefaultPadding),
              OrderSummarySection(),
              Spacer(),
              CustomBtn(
                text: "CONFIRM",
                boxColor: kPrimaryColor,
                onPressed: _submitOrder,
                textColor: Colors.white,
              ),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Checkout',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }

  Widget _buildLoadingText(BuildContext context) {
    return Center(
      child: Text(
        "Loading...",
        style: Theme.of(context).textTheme.caption!.copyWith(color: kGreyColor),
      ),
    );
  }
}
