import 'dart:convert';

import 'package:haiya_client/shared/models/rating.dart';
import 'package:http/http.dart' as http;

class RatingService {
  var basedUri = 'http://10.0.2.2:8080/api/rating';

  Future<List<Rating>> getPharmacyRatingByPharId(int pharmacyId) async {
    List<Rating> result = [];

    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/pharmacy/${pharmacyId}'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    // Handle response
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      result =
          body['data'].map<Rating>((json) => Rating.fromJson(json)).toList();
    }

    return result;
  }
}
