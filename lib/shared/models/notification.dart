import 'package:haiya_client/shared/helper/time_ago.dart';

class Notifications {
  final int id;
  final String title;
  final String body;
  final String timestamp;
  final String type;

  Notifications({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['ID'],
      title: json['Noti_Title'],
      body: json['Noti_Body'],
      timestamp: TimeAgo().displayTimeAgoFromTimestamp(json['Noti_Timestamp']),
      type: json['Noti_Type'],
    );
  }
}

List<Notifications> notifications = [];
