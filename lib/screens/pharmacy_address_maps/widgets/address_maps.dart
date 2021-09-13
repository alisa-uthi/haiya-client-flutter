import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/directions.dart';
import 'package:haiya_client/shared/services/directions_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class AddressMaps extends StatefulWidget {
  final LatLng originPosition;
  final LatLng destinationPosition;

  const AddressMaps({
    Key? key,
    required this.originPosition,
    required this.destinationPosition,
  }) : super(key: key);

  @override
  _AddressMapsState createState() => _AddressMapsState();
}

class _AddressMapsState extends State<AddressMaps> {
  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  DirectionsService _directionsService = new DirectionsService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    // Set origin marker
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: widget.originPosition,
      );
    });

    // Set origin marker
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: widget.originPosition,
      );
    });

    _getDirections();
  }

  // Get directions
  Future<void> _getDirections() async {
    final directions = await _directionsService.getDirections(
      origin: widget.originPosition,
      destination: widget.destinationPosition,
    );
    if (directions != null) {
      setState(() => _info = directions);
    }
    setState(() => _isLoading = false);
  }

  CameraPosition _getInitialPosition() {
    return CameraPosition(
      target: LatLng(
        widget.originPosition.latitude,
        widget.originPosition.longitude,
      ),
      zoom: 11.5,
    );
  }

  @override
  void dispose() {
    if (_googleMapController != null) {
      _googleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _getInitialPosition(),
                onMapCreated: (controller) => _googleMapController = controller,
                markers: _origin != null && _destination != null
                    ? {_origin!, _destination!}
                    : {},
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: const PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info!.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              Positioned(
                top: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: _info != null
                      ? Text(
                          '${_info!.totalDistance}, ${_info!.totalDuration}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        )
                      : Container(),
                ),
              ),
            ],
          )
        : Loader();
  }
}
