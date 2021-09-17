class NotificationSubscription {
  final int id;
  final String token;
  final bool subscribe;
  final String timestamp;
  final String notificationType;

  NotificationSubscription({
    required this.id,
    required this.token,
    required this.subscribe,
    required this.timestamp,
    required this.notificationType,
  });

  factory NotificationSubscription.fromJson(Map<String, dynamic> json) {
    return NotificationSubscription(
      id: json['ID'],
      token: json['Scp_Registration_Token'],
      subscribe: json['Scp_Subscribe'] == 'T' ? true : false,
      timestamp: json['Scp_Timestamp'],
      notificationType: json['Scp_Notification_Type'],
    );
  }
}
