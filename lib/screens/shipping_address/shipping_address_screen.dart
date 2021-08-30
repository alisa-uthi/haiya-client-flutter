import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/add_shipping_address/add_address_screen.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/services/user_service.dart';

import 'widgets/address_card.dart';
import 'widgets/no_address_saved.dart';

class ShippingAddressScreen extends StatefulWidget {
  static final routeName = '/shipping-address';

  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUserAddress();
  }

  Future<dynamic> _fetchUserAddress() async {
    UserService _userService = new UserService();
    await _userService.getAddressByUserId();
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
          width: double.infinity,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: userAddress.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: userAddress.length,
                        itemBuilder: (builder, index) {
                          var address = userAddress[index];
                          return AddressCard(address: address);
                        },
                      ),
                      _buildAddButton(context),
                    ],
                  ),
                )
              : NoAddressSaved(),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                AddAddressScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: new Icon(
        Icons.add,
        color: Colors.white,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
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
