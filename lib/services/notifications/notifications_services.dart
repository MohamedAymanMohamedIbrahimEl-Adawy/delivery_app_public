import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../data/constants/constants.dart';

class NotificationsServices {
  // Private constructor
  NotificationsServices._internal();

  // //NotificationService a singleton object
  // static final NotificationsServices _notificationService =
  //     NotificationsServices._internal();

  factory NotificationsServices() {
    //NotificationService a singleton object
    return NotificationsServices._internal();
  }

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void handleOnClickNotification(
      NotificationsModel? notificationsModel) async {
    //handle on click notifiction whether if it's from firebase or from locale notification plugin
    try {} catch (_) {}
    return;
  }

  Future<void> init() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // Request Notifications permission
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    if (kDebugMode) {
      print('Users permission == ${notificationSettings.authorizationStatus}');
    }
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      await firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        sound: true,
        badge: true,
      );
      return;
    }

    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOSInitialize = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        handleOnClickNotification(
          NotificationsModel.fromJson(json.decode(details.payload!)),
        );
      },
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse details) {
        handleOnClickNotification(
          NotificationsModel.fromJson(json.decode(details.payload!)),
        );
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);

    // Handle notifications on foreground
    //--> This is the only case where we use locale notifiction plugin to show the notifiction
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
            "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print(
            "onMessage came while the app on foreground state type: ${message.data['type']}/${message.data}");
      }
      NotificationsServices.showNotification(
        message,
        flutterLocalNotificationsPlugin,
        false,
      );
    });

    // Handle notifications on background
    // --> In this case the app was in the background, and the notification was clicked and moved app to the foreground
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (kDebugMode) {
          print(
              "onOpenApp from Background State: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        }
        try {
          if (message.data.isNotEmpty) {
            NotificationsModel notificationsModel =
                convertNotification(message.data);
            // Handle on Click notification
            handleOnClickNotification(notificationsModel);
          }
        } catch (_) {}
      },
    );

    // Handle on terminated state
    // --> In this case the app was opend from the terminated by clicking the notifications

    firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (kDebugMode) {
          print(
              "onOpenApp From Terminated state: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        }
        try {
          if (message.data.isNotEmpty) {
            NotificationsModel notificationsModel =
                convertNotification(message.data);
            handleOnClickNotification(notificationsModel);
          }
        } catch (_) {}
      }
    });
  }

  AndroidNotificationChannel notificationChannel =
      const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title/ description
    playSound: true,
    importance: Importance.max,
  );
  static Future<void> showNotification(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin fln,
    bool data,
  ) async {
    if (!Platform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      NotificationsModel notificationsModel = convertNotification(message.data);
      if (data) {
        title = message.data['title'];
        body = message.data['body'];
        orderID = message.data['order_id'];
        image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image'].startsWith('http')
                    ? message.data['image']
                    : '${Constants.baseUrl}/.../${message.data['image']}'
                : null;
      } else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if (Platform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null &&
                  message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http')
                  ? message.notification!.android!.imageUrl
                  : '${Constants.baseUrl}/.../${message.data['image']}'
              : null;
        } else if (Platform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null &&
                  message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http')
                  ? message.notification!.apple!.imageUrl
                  : '${Constants.baseUrl}/.../${message.data['image']}'
              : null;
        }
      }

      if (image != null && image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
            title,
            body,
            orderID,
            notificationsModel,
            image,
            fln,
          );
        } catch (e) {
          await showBigTextNotification(
            title,
            body!,
            orderID,
            notificationsModel,
            fln,
          );
        }
      } else {
        await showBigTextNotification(
          title,
          body!,
          orderID,
          notificationsModel,
          fln,
        );
      }
    }
  }

  static Future<void> showTextNotification(
      String title,
      String body,
      String orderID,
      NotificationsModel? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Constants.appName,
      Constants.appName,
      playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: notificationBody != null
          ? jsonEncode(notificationBody.toJson())
          : null,
    );
  }

  static Future<void> showBigTextNotification(
      String? title,
      String body,
      String? orderID,
      NotificationsModel? notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Constants.appName,
      Constants.appName,
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: notificationBody != null
          ? jsonEncode(notificationBody.toJson())
          : null,
    );
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String? title,
      String? body,
      String? orderID,
      NotificationsModel? notificationBody,
      String image,
      FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      Constants.appName,
      Constants.appName,
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: notificationBody != null
          ? jsonEncode(notificationBody.toJson())
          : null,
    );
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory =
        await getTemporaryDirectory(); //getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationsModel convertNotification(Map<String, dynamic> data) {
    if (data['type'] == 'notification') {
      return NotificationsModel(type: 'notification');
    } else if (data['type'] == 'order') {
      return NotificationsModel(
          type: 'order', orderId: int.parse(data['order_id']));
    } else {
      return NotificationsModel(type: 'chatting');
    }
  }
}

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(
        "onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
}

class NotificationsModel {
  int? orderId;
  String? type;

  NotificationsModel({
    this.orderId,
    this.type,
  });

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['type'] = type;
    return data;
  }
}
