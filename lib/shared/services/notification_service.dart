import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/models/notification_subscription.dart';
import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  var basedUri = 'http://10.0.2.2:8080/api/notification';

  Future<void> getNotificationsByUserId() async {
    var response = await http.get(
      Uri.parse('$basedUri/user/${currentUser.id}'),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      notifications = body['data']
          .map<Notifications>((noti) => Notifications.fromJson(noti))
          .toList();
    }
  }

  Future<bool> deleteNotificationsByUserId() async {
    var response = await http.delete(
      Uri.parse('$basedUri/user/${currentUser.id}'),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }

  Future<Notifications?> getNotificationById(int id) async {
    Notifications? noti;

    var response = await http.get(
      Uri.parse('$basedUri/$id'),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      noti = Notifications.fromJson(body['data']);
    }
    return noti;
  }

  Future<bool> deleteNotificationById(int id) async {
    var response = await http.delete(
      Uri.parse('$basedUri/$id'),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }

  Future<NotificationSubscription?> getSubscriptionByToken(
      String registrationToken) async {
    NotificationSubscription? subscription;

    // Call Api
    var response = await http.post(
      Uri.parse('${basedUri}/subscription/token'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'registrationToken': registrationToken,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      if (body.isEmpty) return null;
      subscription = NotificationSubscription.fromJson(body['data']);
    }
    return subscription;
  }

  Future<NotificationSubscription?> getSubscriptionByUserId() async {
    NotificationSubscription? subscription;
    // Call Api
    var response = await http.get(
      Uri.parse('${basedUri}/subscription/user/${currentUser.id}'),
    );

    if (response.statusCode >= 200 && response.statusCode < 205) {
      Map<String, dynamic> body = jsonDecode(response.body);
      subscription = NotificationSubscription.fromJson(body['data']);
    }
    return subscription;
  }

  Future<void> subscribeToNotificationSubscription(
    String registrationToken,
    String notificationType,
  ) async {
    // Call Api
    await http.post(
      Uri.parse('${basedUri}/subscription/user/${currentUser.id}'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'registrationToken': registrationToken,
        'notificationType': notificationType.toUpperCase(),
      }),
    );
  }

  Future<bool> updateSubscription(
    String registrationToken,
    String notificationType,
    bool isSubscribe,
  ) async {
    // Call Api
    var response = await http.patch(
      Uri.parse('$basedUri/subscription/user/${currentUser.id}'),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode({
        'registrationToken': registrationToken,
        'notificationType': notificationType.toUpperCase(),
        'subscribe': isSubscribe,
      }),
    );

    // Handle response
    if (response.statusCode >= 200 && response.statusCode < 205) {
      return true;
    }
    return false;
  }
}
