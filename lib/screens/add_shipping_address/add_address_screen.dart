import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/screens/add_shipping_address/widgets/shipping_address_form.dart';
import 'package:haiya_client/shared/models/address.dart';

import '../../constants.dart';
import 'widgets/address_map.dart';

class AddAddressScreen extends StatefulWidget {
  static final routeName = '/add-shipping-address';

  const AddAddressScreen({
    Key? key,
    this.address,
  }) : super(key: key);
  final Address? address;

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool _isLoading = true;
  ValueNotifier<String> _location = ValueNotifier('');
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (widget.address != null) {
      setState(() {
        _location.value = widget.address!.location;
        _latLng =
            new LatLng(widget.address!.latitude!, widget.address!.longitude!);
      });
    }
  }

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
          '$street, $name, $subLocality, $province, $postalCode, $country';
      _isLoading = false;
    });

    _location.notifyListeners();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddressMap(
                initialPosition: _latLng != null ? _latLng : null,
                onChangeLocation: (placemarks, latLng) {
                  changeLocation(placemarks);
                  setState(() => _latLng = latLng);
                },
              ),
              if (_isLoading == false)
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: _location,
                          builder: (context, value, child) {
                            return ShippingAddressForm(
                              currentAddress: widget.address != null
                                  ? widget.address!
                                  : null,
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
