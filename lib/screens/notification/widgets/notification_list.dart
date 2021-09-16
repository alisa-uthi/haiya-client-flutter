import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import 'notification_item.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    Key? key,
    required this.onDeleteNoti,
  }) : super(key: key);

  final Function onDeleteNoti;

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  NotificationService _notificationService = new NotificationService();
  ValueNotifier<List<Notifications>> _notifications = ValueNotifier([]);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotification();
  }

  Future<void> _fetchNotification() async {
    await _notificationService.getNotificationsByUserId();
    if (!mounted) return;
    setState(() => {
          _notifications.value = notifications,
          _isLoading = false,
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? _notifications.value.length == 0
            ? Center(
                child: Text("No Notifications Yet."),
              )
            : ValueListenableBuilder(
                valueListenable: _notifications,
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      var noti = notifications[index];
                      return NotificationItem(
                        notification: noti,
                        onDeleteNoti: () => {
                          _notifications.notifyListeners(),
                          widget.onDeleteNoti(),
                        },
                      );
                    },
                  );
                },
              )
        : Loader();
  }
}
