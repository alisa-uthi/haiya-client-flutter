import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

import '../../constants.dart';
import 'widgets/notification_list.dart';

class NotificationScreen extends StatefulWidget {
  static final routeName = '/notification';

  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationService _notificationService = new NotificationService();

  Future<void> _clearAllNotifications() async {
    bool isDeleted = await _notificationService.deleteNotificationsByUserId();
    if (isDeleted) {
      notifications.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      bottomNavigationBar: BottomNavBar(index: 2),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notfication",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  GestureDetector(
                    onTap: _clearAllNotifications,
                    child: Text(
                      "Clear All",
                      style: TextStyle(
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              NotificationList(),
            ],
          ),
        ),
      ),
    );
  }
}
