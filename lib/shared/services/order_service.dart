import 'dart:convert';

import 'package:haiya_client/shared/models/delivery.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/models/order_line.dart';
import 'package:haiya_client/shared/models/user_detail.dart';

import 'package:http/http.dart' as http;

class OrderService {
  var basedUri = 'http://10.0.2.2:8080/api/order';

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${currentUser.token}',
  };

  Future<bool> createOrder({
    required String deliveryAddress,
    required int deliveryPrice,
    required String comment,
    required String pharmacy,
  }) async {
    // Convert List<OrderLine> to normal array of objects
    var orderLines = [];
    for (int i = 0; i < cart.length; i++) {
      var obj = {
        'productId': cart[i].productId,
        'quantity': cart[i].quantity,
        'totalCost': cart[i].totalCost,
        'comment': cart[i].comment
      };
      orderLines.add(obj);
    }

    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/user/${currentUser.id}'),
      headers: requestHeaders,
      body: jsonEncode({
        'deliveryAddress': deliveryAddress,
        'deliveryPrice': deliveryPrice,
        'comment': comment,
        'pharmacy': pharmacy,
        'orderLines': orderLines,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      cart.clear();
      return true;
    }
    return false;
  }

  Future<List<Order>> getPurchaseHistories() async {
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/user/${currentUser.id}'),
      headers: requestHeaders,
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['data'].map<Order>((json) => Order.fromJson(json)).toList();
    }

    return [];
  }

  Future<Order?> getOrderById(int id) async {
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/${id}'),
      headers: requestHeaders,
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return Order.fromJson(body['data']);
    }

    return null;
  }

  Future<List<Order>> getOrdersByOrderStatus(String orderStatus) async {
    // Call Api
    var response = await http.get(
      Uri.parse(
          '${basedUri}/user/${currentUser.id}/orderStatus/${orderStatus}'),
      headers: requestHeaders,
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['data'].map<Order>((json) => Order.fromJson(json)).toList();
    }

    return [];
  }

  Future<List<Delivery>> getDeliveryByOrderId(int orderId) async {
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/${orderId}/delivery'),
      headers: requestHeaders,
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['data']
          .map<Delivery>((json) => Delivery.fromJson(json))
          .toList();
    }

    return [];
  }
}
