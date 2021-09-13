import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/screens/pharmacy_address_maps/widgets/address_maps.dart';
import 'package:haiya_client/shared/models/address.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class PharmacyAddressMapsScreen extends StatefulWidget {
  static final routeName = '/pharmacy-address-map';

  PharmacyAddressMapsScreen({
    Key? key,
    required this.pharmacyName,
    required this.address,
  }) : super(key: key);

  final String pharmacyName;
  final Address address;

  @override
  _PharmacyAddressMapsScreenState createState() =>
      _PharmacyAddressMapsScreenState();
}

class _PharmacyAddressMapsScreenState extends State<PharmacyAddressMapsScreen> {
  UserService _userService = new UserService();
  LatLng _origin = new LatLng(0.0, 0.0);
  LatLng _destination = new LatLng(0.0, 0.0);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    await _getUserCurrentCoordinates();
    setState(() {
      _destination =
          new LatLng(widget.address.latitude!, widget.address.longitude!);
      _isLoading = false;
    });
  }

  Future<void> _getUserCurrentCoordinates() async {
    LatLng result = await _userService.getCurrentCoordinates();
    setState(() {
      _origin = result;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pharmacyName,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: !_isLoading
          ? AddressMaps(
              originPosition: _origin,
              destinationPosition: _destination,
            )
          : Loader(),
    );
  }
}
