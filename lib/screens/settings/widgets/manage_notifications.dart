import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/notification_subscription.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';

class ManageNotifications extends StatefulWidget {
  const ManageNotifications({
    Key? key,
  }) : super(key: key);

  @override
  _ManageNotificationsState createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  bool _orderStatus = true;
  NotificationSubscription? _notificationSubscription;
  NotificationService _notificationService = new NotificationService();

  @override
  void initState() {
    super.initState();
    _fetchSubscription();
  }

  Future<void> _fetchSubscription() async {
    NotificationSubscription? result =
        await _notificationService.getSubscriptionByUserId();
    if (result != null) {
      setState(() {
        _notificationSubscription = result;
        _orderStatus = _notificationSubscription!.subscribe;
      });
    }
  }

  Future<void> _toggleNotification(
    String notificationType,
    bool isSubscribe,
  ) async {
    if (_notificationSubscription != null) {
      bool isUpdated = await _notificationService.updateSubscription(
        _notificationSubscription!.token,
        notificationType,
        isSubscribe,
      );

      if (!isUpdated) {
        // If error occurs, set boolean back to value it was
        setState(() => isSubscribe != isSubscribe);
        CustomSnackBar.buildSnackbar(context, kGeneralError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Manage Notifications",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: kDefaultPadding / 2),

        // Order Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Orders"),
            Switch(
              value: _orderStatus,
              activeColor: kPrimaryColor,
              activeTrackColor: kPrimaryColor.withOpacity(0.5),
              onChanged: (value) {
                setState(() => _orderStatus = value);
                _toggleNotification('ORDER_ARRIVED', _orderStatus);
              },
            ),
          ],
        ),
      ],
    );
  }
}
