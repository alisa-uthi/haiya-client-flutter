import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class ManageNotifications extends StatefulWidget {
  const ManageNotifications({
    Key? key,
  }) : super(key: key);

  @override
  _ManageNotificationsState createState() => _ManageNotificationsState();
}

class _ManageNotificationsState extends State<ManageNotifications> {
  bool _deliveryStatus = false, _productExpiration = false;

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

        // Delivery Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Delivery Status"),
            Switch(
              value: _deliveryStatus,
              activeColor: kPrimaryColor,
              activeTrackColor: kPrimaryColor.withOpacity(0.5),
              onChanged: (value) {
                setState(() => _deliveryStatus = !_deliveryStatus);
              },
            ),
          ],
        ),
      ],
    );
  }
}
