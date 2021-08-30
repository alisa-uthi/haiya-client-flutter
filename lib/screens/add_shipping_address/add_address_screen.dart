import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/screens/add_shipping_address/widgets/shipping_address_form.dart';

import '../../constants.dart';
import 'widgets/address_map.dart';

class AddAddressScreen extends StatefulWidget {
  static final routeName = '/add-shipping-address';

  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool _isLoading = true;
  ValueNotifier<String> _location = ValueNotifier('');
  LatLng? _latLng;

  void changeLocation(placemarks) {
    setState(() {
      _isLoading = true;
    });

    String? street = placemarks[0].street;
    String? name = placemarks[0].name;
    String? subLocality = placemarks[0].subLocality;
    String? province = placemarks[0].administrativeArea;
    String? postalCode = placemarks[0].postalCode;
    String? country = placemarks[0].country;

    setState(() {
      _location.value =
          '${street}, ${name}, ${subLocality}, ${province}, ${postalCode}, ${country}';
      _isLoading = false;
    });

    _location.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddressMap(onChangeLocation: (placemarks, latLng) {
                changeLocation(placemarks);
                setState(() => _latLng = latLng);
              }),
              if (_isLoading == false)
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: _location,
                          builder: (context, value, child) {
                            return ShippingAddressForm(
                              location: _location.value,
                              coordinates: _latLng!,
                            );
                          }),
                      SizedBox(height: kDefaultPadding),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Adding Shipping Address',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
