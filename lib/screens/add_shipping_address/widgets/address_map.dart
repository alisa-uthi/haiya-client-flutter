import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class AddressMap extends StatefulWidget {
  final Function onChangeLocation;
  final LatLng? initialPosition;

  const AddressMap({
    Key? key,
    this.initialPosition,
    required this.onChangeLocation,
  }) : super(key: key);

  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _initialPosition;
  final Set<Marker> _markers = {};
  bool _isLoading = true;
  List<Placemark> _placemarks = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialPosition != null && mounted) {
      setState(() {
        _initialPosition = widget.initialPosition;
        _onAddMarkerButtonPressed(_initialPosition!);
        _isLoading = false;
      });
    } else if (mounted) {
      _fetchCurrentLocation();
    }
  }

  Future<dynamic> _fetchCurrentLocation() async {
    UserService _userService = new UserService();
    LatLng currentPosition = await _userService.getCurrentCoordinates();

    setState(() {
      _initialPosition =
          LatLng(currentPosition.latitude, currentPosition.longitude);
    });
    _onAddMarkerButtonPressed(_initialPosition!);

    setState(() => _isLoading = false);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onAddMarkerButtonPressed(LatLng latLng) async {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    // Get place name
    _placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    widget.onChangeLocation(_placemarks, latLng);
  }

  @override
  void dispose() {
    _controller.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialPosition!,
                zoom: 15.0,
              ),
              markers: _markers,
              onTap: (latLng) {
                _onAddMarkerButtonPressed(latLng);
              },
            ),
          );
  }
}
