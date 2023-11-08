class Notification {
  String? notificationID;
  String title;
  String body;
  DateTime sentAt;
  DateTime receivedAt;
  String deviceToken;

  Notification(
      {required this.title,
      required this.body,
      required this.sentAt,
      required this.receivedAt,
      required this.deviceToken});
}
