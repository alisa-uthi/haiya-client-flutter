import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/widgets/custom_card.dart';

import '../../../constants.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onDeleteNoti,
  }) : super(key: key);

  final Notifications notification;
  final Function onDeleteNoti;

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  NotificationService _notificationService = new NotificationService();

  Future<void> _onDeleteNoti() async {
    bool isDeleted = await _notificationService
        .deleteNotificationById(widget.notification.id);
    if (isDeleted) {
      notifications.remove(widget.notification);
      widget.onDeleteNoti();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        _buildDeleteIconSlide(),
      ],
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding / 1.5),
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.notification.timestamp,
                      style: TextStyle(color: kGreyColor),
                    )
                  ],
                ),
                Text(
                  widget.notification.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 5),
                Text(
                  widget.notification.body,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteIconSlide() {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 1.5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(kDefaultPadding / 2),
          bottomRight: Radius.circular(kDefaultPadding / 2),
        ),
      ),
      child: IconSlideAction(
        caption: 'Delete',
        color: Colors.transparent,
        iconWidget: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        onTap: _onDeleteNoti,
      ),
    );
  }
}
