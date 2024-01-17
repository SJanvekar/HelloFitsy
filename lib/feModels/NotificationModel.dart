class NotificationModel {
  String? notificationID;
  String? title;
  String? body;
  DateTime sentAt;
  DateTime receivedAt;
  String? deviceToken;

  NotificationModel({
    required this.title,
    required this.body,
    required this.sentAt,
    required this.receivedAt,
    // required this.deviceToken
  });
}
