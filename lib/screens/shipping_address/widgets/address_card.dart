import 'package:flutter/material.dart';
import 'package:haiya_client/screens/add_shipping_address/add_address_screen.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  final Address address;

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  bool _isShippingAddress = false;
  UserService _userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding / 2),
          child: Column(
            children: [
              _buildAddressName(context),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                widget.address.location,
                overflow: TextOverflow.clip,
              ),
              SizedBox(height: kDefaultPadding / 2),
              _buildCheckboxAddressRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxAddressRow() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.black,
          value: _isShippingAddress,
          onChanged: (value) async {
            setState(() => _isShippingAddress = value!);
            bool isUpdated = await _userService.updateShippingAddressStatus(
              addressId: widget.address.id,
              isShippingAddress: _isShippingAddress,
            );
            // TODO: do something
          },
        ),
        Text("Use as the shipping address"),
      ],
    );
  }

  Widget _buildAddressName(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.address.name),
        TextButton(
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
          child: Text(
            "Edit",
            style: TextStyle(
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
