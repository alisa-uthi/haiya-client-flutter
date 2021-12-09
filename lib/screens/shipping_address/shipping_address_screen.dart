import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/checkout_order/checkout_order_screen.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';

import 'widgets/add_address_button.dart';
import 'widgets/address_card.dart';
import 'widgets/no_address_saved.dart';

class ShippingAddressScreen extends StatefulWidget {
  static final routeName = '/shipping-address';

  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  ValueNotifier<List<Address>> _userAddress = ValueNotifier(userAddress);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: _userAddress,
              builder: (context, child, value) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: userAddress.length != 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...List.generate(
                              userAddress.length,
                              (index) {
                                var address = userAddress[index];

                                return AddressCard(
                                  address: address,
                                  onChangedCheckbox: () =>
                                      _userAddress.notifyListeners(),
                                );
                              },
                            ),
                            AddAddressButton(),
                            SizedBox(height: kDefaultPadding * 2),
                            CustomBtn(
                              text: "CONFIRM",
                              boxColor: kPrimaryColor,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            CheckoutOrderScreen(),
                                    transitionDuration: Duration(seconds: 0),
                                  ),
                                );
                              },
                              textColor: Colors.white,
                            ),
                            SizedBox(height: kDefaultPadding),
                          ],
                        )
                      : NoAddressSaved(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Shipping Address',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
