import 'dart:convert';

import 'package:haiya_client/shared/models/category.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  var basedUri = 'http://10.0.2.2:8080/api/inventory';

  Future<void> getAllProductCategories() async {
    var response = await http.get(Uri.parse('${basedUri}/category'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      allCategories = body['data']
          .map<Category>((json) => Category.fromJson(json))
          .toList();
    }
  }
}
