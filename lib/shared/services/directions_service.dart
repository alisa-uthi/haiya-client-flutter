import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/directions.dart';
import 'package:http/http.dart' as http;

class DirectionsService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    // TODO: Replace google API key
    final response = await http.get(
      Uri.parse(
          '${_baseUrl}origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=<APIKEY>}'),
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return Directions.fromJson(body['data']);
    }
    return null;
  }
}
