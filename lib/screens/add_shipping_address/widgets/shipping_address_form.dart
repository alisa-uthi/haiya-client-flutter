import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/shipping_address/shipping_address_screen.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/form_fields.dart';

class ShippingAddressForm extends StatefulWidget {
  const ShippingAddressForm({
    Key? key,
    required this.location,
    required this.coordinates,
  }) : super(key: key);

  final String location;
  final LatLng coordinates;

  @override
  _ShippingAddressFormState createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm> {
  UserService _userService = new UserService();
  final _formKey = GlobalKey<FormState>();
  FormFields _formFields = new FormFields();
  String _addressName = '', _location = '', _note = '';

  @override
  void initState() {
    super.initState();
    setState(() => _location = widget.location);
  }

  @override
  void didUpdateWidget(ShippingAddressForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.location != oldWidget.location) {
      setState(() => _location = widget.location);
    }
  }

  Future<void> _onSaveAddress() async {
    if (_formKey.currentState!.validate()) {
      bool isAdded = await _userService.addNewAddress(
        name: _addressName,
        location: _location,
        note: _note,
        coordinate: widget.coordinates,
      );

      if (isAdded) {
        await _userService.getAddressByUserId();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                ShippingAddressScreen(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        CustomSnackBar.buildSnackbar(
          context,
          'Unable to add your address. Please try again.',
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Address Name
          _formFields.buildTextRequiredField(
            "Address Name",
            _addressName,
            (value) => setState(() => _addressName = value!),
          ),
          SizedBox(height: kDefaultPadding / 2),

          // Address's Location
          CustomCard(
            child: TextFormField(
              key: Key(widget.location),
              initialValue: widget.location,
              textInputAction: TextInputAction.next,
              decoration:
                  cardInputDecoration.copyWith(labelText: 'Address Detail'),
              onChanged: (value) => setState(() => _location = value),
              validator: (value) {
                if (value!.isEmpty) {
                  return kFieldNullError + 'Address Detail';
                }
                return null;
              },
            ),
          ),

          // Additional Detail
          SizedBox(height: kDefaultPadding / 2),
          _formFields.buildTextField(
            "Additional Detail",
            _note,
            (value) => setState(() => _note = value!),
          ),
          SizedBox(height: kDefaultPadding * 2),

          // Save Button
          CustomBtn(
            text: "SAVE ADDRESS",
            boxColor: kPrimaryColor,
            onPressed: _onSaveAddress,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
