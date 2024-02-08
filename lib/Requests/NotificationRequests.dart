import 'dart:async';

import 'package:balance/Constants.dart';
import 'package:balance/feModels/NotificationModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Define a callback function type for displaying a notification
typedef DidReceiveLocalNotificationSubject = Future<void> Function();

// Define a callback function type for selecting a notification
typedef SelectNotificationSubject = Future<void> Function();

class NotificationRequests {
  //Private constructor
  NotificationRequests._();

  Dio dio = new Dio();

  int id = 0;

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<NotificationModel>
      didReceiveLocalNotificationStream =
      StreamController<NotificationModel>.broadcast();

  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  String? selectedNotificationPayload;

  /// A notification action which triggers a App navigation event
  static const String navigationActionId = 'id_1';

  /// Defines a iOS/MacOS notification category for text input actions.
  static const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  //Singleton instance
  static NotificationRequests? _instance;

  //Getter for the singleton instance
  static NotificationRequests get instance {
    _instance ??= NotificationRequests._(); // Initialize instance if it's null
    return _instance!;
  }

  // Initialization method
  static Future<void> initialize() async {
    // Your initialization code goes here
    print('Initialization code ran once');

    //Request notification permissions
    _requestPermissions();

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          NotificationModel(
              title: title,
              body: body,
              sentAt: DateTime.now(),
              receivedAt: DateTime.now()),
        );
      },
      notificationCategories: darwinNotificationCategories,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsDarwin,
      // macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Cleanup method
  static void cleanup() {
    // Your cleanup code goes here
    print('Cleanup code ran');
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
  }

  // Other methods or properties can be added as needed
  void doSomething() {
    print('Doing something');
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  static Future<void> _requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  //Create Test Notification
  Future<void> addTestNotification(
      DidReceiveLocalNotificationSubject receiveCallback,
      SelectNotificationSubject selectCallback) async {
    didReceiveLocalNotificationStream.stream
        .listen((NotificationModel receivedNotification) async {
      await receiveCallback();
    });

    selectNotificationStream.stream.listen((String? payload) async {
      await selectCallback();
    });

    print("Triggering notificaiton");
    print(id);
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentSound: true,
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item z');

    tz.initializeTimeZones();
    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(
      DateTime.now(),
      tz.getLocation('America/New_York'), // Replace with your desired time zone
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id++,
        'scheduled title',
        'scheduled body',
        tzDateTime.add(const Duration(seconds: 5)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'item z');
  }

  //Create Test Notification
  addTestPushNotification(String? fcmToken) async {
    try {
      return await dio.get(
        '$urlDomain/addTestPushNotification',
        queryParameters: {
          "fcmToken": fcmToken,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
