import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haiya_client/shared/models/notification_subscription.dart';
import 'package:haiya_client/shared/services/notification_service.dart';

class FirebaseMessagingHelper {
  NotificationService _notificationService = new NotificationService();

  Future<void> initilizeMessagingAndNotification() async {
    await Firebase.initializeApp();

    /// Create a [AndroidNotificationChannel] for heads up notifications
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Initialize the [FlutterLocalNotificationsPlugin] package.
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Get Registration token and subscribe it to notification
    // String? token = await FirebaseMessaging.instance.getToken();
    // if (token != null) {
    //   NotificationSubscription? existingSubscription =
    //       await _notificationService.getSubscriptionByToken(token);
    //   if (existingSubscription == null) {
    //     await _notificationService.subscribeToNotificationSubscription(
    //       token,
    //       "ORDER_ARRIVED",
    //     );
    //   }
    // }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;

      flutterLocalNotificationsPlugin.show(
        1,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            '10000',
            'FLUTTER_NOTIFICATION_CHANNEL',
            'FLUTTER_NOTIFICATION_CHANNEL_DETAIL',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });
  }

  Future<void> getTokenAndSubscribe() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      NotificationSubscription? existingSubscription =
          await _notificationService.getSubscriptionByToken(token);
      if (existingSubscription == null) {
        _notificationService.subscribeToNotificationSubscription(
          token,
          "ORDER_ARRIVED",
        );
        _notificationService.subscribeToNotificationSubscription(
          token,
          "ORDER_OTW_PHARMACY",
        );
        _notificationService.subscribeToNotificationSubscription(
          token,
          "ORDER_PICKEDUP",
        );
      }
    }
  }
}
