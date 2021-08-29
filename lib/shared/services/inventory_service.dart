import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/operation_time.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  var basedUri = 'http://10.0.2.2:8080/api/inventory';

  bool isPharmacyOpen(OperationTime opt) {
    String openHr = opt.openHr.substring(0, 2);
    String openMin = opt.openHr.substring(3, 5);
    String closeHr = opt.closeHr.substring(0, 2);
    String closeMin = opt.closeHr.substring(3, 5);

    List<TimeOfDay> openingTimeRange = [
      TimeOfDay(hour: int.parse(openHr), minute: int.parse(openMin)),
      TimeOfDay(hour: int.parse(closeHr), minute: int.parse(closeMin)),
    ];
    TimeOfDay now = TimeOfDay.now();

    if (now.hour == openingTimeRange[0].hour) {
      return now.minute >= openingTimeRange[0].minute &&
          now.hour <= openingTimeRange[1].hour;
    } else if (now.hour > openingTimeRange[0].hour) {
      if (now.hour < openingTimeRange[1].hour) {
        return true;
      } else if (now.hour == openingTimeRange[1].hour) {
        return now.minute >= openingTimeRange[1].minute;
      }
    }
    return false;
  }

  Future<void> getAllPharmacies() async {
    // Get current location coordinates
    UserService userService = new UserService();
    LatLng latlng = await userService.getCurrentCoordinates();

    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/pharmacy'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'latitude': latlng.latitude,
        'longitude': latlng.longitude,
      }),
    );

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      allPharmacies = body['data']
          .map<Pharmacy>((json) => Pharmacy.fromJson(json))
          .toList();
    }
  }

  Future<void> getNearestPharmacies() async {
    // Get current location coordinates
    UserService userService = new UserService();
    LatLng latlng = await userService.getCurrentCoordinates();

    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/pharmacy/nearest'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'latitude': latlng.latitude,
        'longitude': latlng.longitude,
      }),
    );

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      nearestPharmacies = body['data']
          .map<Pharmacy>((json) => Pharmacy.fromJson(json))
          .toList();
    }
  }

  Future<void> getAllProductCategories() async {
    // Call Api
    var response = await http.get(Uri.parse('${basedUri}/category'));

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      allCategories = body['data']
          .map<Category>((json) => Category.fromJson(json))
          .toList();
    }
  }

  Future<List<Product>> getProductByCategory(int categoryId) async {
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/product/category/${categoryId}'),
    );

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Product> products =
          body['data'].map<Product>((json) => Product.fromJson(json)).toList();

      return products;
    }

    return [];
  }

  Future<List<Product>> getProductByCategoryAndPharmacy(
    int pharmacyId,
    int categoryId,
  ) async {
    // Call Api
    var response = await http.get(
      Uri.parse(
          '${basedUri}/product/catalog/${pharmacyId}/category/${categoryId}'),
    );

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Product> products =
          body['data'].map<Product>((json) => Product.fromJson(json)).toList();

      return products;
    }

    return [];
  }
}
