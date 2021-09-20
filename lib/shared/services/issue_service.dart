import 'dart:convert';

import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:http/http.dart' as http;

class IssueService {
  var basedUri = 'http://10.0.2.2:8080/api/issue';

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${currentUser.token}',
  };

  Future<bool> sendIssueReport({
    required String email,
    required String issue,
    required String type,
    required String detail,
  }) async {
    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/user/${currentUser.id}'),
      headers: requestHeaders,
      body: jsonEncode({
        'title': issue,
        'category': type,
        'email': email,
        'detail': detail,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }
}
