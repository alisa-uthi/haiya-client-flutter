import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

class UserService {
  var basedUri = 'http://10.0.2.2:8080/api/user';

  Future<void> updateProfileImage(String filePath) async {
    print("Update profile image: " + filePath);
  }

  Future<LatLng> getCurrentCoordinates() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    return LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  Future<String> getCurrentLocation() async {
    LatLng latLng = await getCurrentCoordinates();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    String? street = placemarks[0].street;
    String? name = placemarks[0].name;
    String? subLocality = placemarks[0].subLocality;
    String? province = placemarks[0].administrativeArea;
    String? postalCode = placemarks[0].postalCode;
    String? country = placemarks[0].country;

    return '${street}, ${name}, ${subLocality}, ${province}, ${postalCode}, ${country}';
  }
}
