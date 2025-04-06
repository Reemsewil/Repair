// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings();

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsIOS,
//         );

//     await _notificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification({
//     required String title,
//     required String body,
//     required int id,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//           'prayer_channel',
//           'Prayer Notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//         );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );

//     await _notificationsPlugin.show(id, title, body, platformChannelSpecifics);
//   }
// }





// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:prayer_tracking_app/features/prayers_time/data/model/prayer_model.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationPlugin =
//       FlutterLocalNotificationsPlugin();

//   bool _isInitialized = false;

//   bool get isInitialized => _isInitialized;

//   Future<void> initNotification() async {
//     if (_isInitialized) return;

//     const initSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const initSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     const initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIOS,
//     );

//     await notificationPlugin.initialize(initSettings);
//     _isInitialized = true;
//   }

//   // **Notification Details**
//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_channel_id',
//         'Daily Notifications',
//         channelDescription: 'Daily Notification Channel',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         enableVibration: true,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

// //_______________________________________________________________
// //** Schedule Notifications :

// Future<void> schedulePrayerNotifications(List<PrayerTimeModel> prayerTimes) async {
//   if (!_isInitialized) {
//     print("⚠️ Notifications not initialized!");
//     await initNotification();
//   }

//   await cancelAllNotifications();
//   print("🧹 Cleared existing notifications");

//   tz.initializeTimeZones();
//   final location = tz.getLocation('Asia/Damascus');
//   tz.setLocalLocation(location);

//   final now = tz.TZDateTime.now(location);
//   print("🕒 Current time: $now");

//   Map<String, int> prayerBaseIds = {
//     "Fajr": 1,
//     "Dhuhr": 2,
//     "Asr": 3,
//     "Maghrib": 4,
//     "Isha": 5,
//   };

//   for (var prayer in prayerTimes) {
//     if (prayer.name == "Sunrise") continue;

//     final prayerDateTime = prayer.time;
//     var scheduledTime = tz.TZDateTime(
//       location,
//       prayerDateTime.year,
//       prayerDateTime.month,
//       prayerDateTime.day,
//       prayerDateTime.hour,
//       prayerDateTime.minute,
//     );

//     if (scheduledTime.isBefore(now)) {
//       print("Skipping past prayer time: ${prayer.name} at $scheduledTime");
//       continue;
//     }

//     final notificationId = prayerBaseIds[prayer.name]! +
//         (prayerDateTime.day * 10) +
//         (prayerDateTime.month * 100);

//     try {
//       await notificationPlugin.zonedSchedule(
//         notificationId,
//         "Prayer Time: ${prayer.name}",
//         "It's time for ${prayer.name} prayer! 🕌",
//         scheduledTime,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'prayer_channel',
//             'Prayer Notifications',
//             channelDescription: 'Notifications for prayer times',
//             importance: Importance.max,
//             priority: Priority.high,
//             enableVibration: true,
//             playSound: true,
//             category: AndroidNotificationCategory.alarm,
//             fullScreenIntent: true,
//             visibility: NotificationVisibility.public,
//           ),
//           iOS: const DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         // uiLocalNotificationDateInterpretation:
//         //     UILocalNotificationDateInterpretation.absoluteTime,
//       );
//       print("✅ Scheduled ${prayer.name} for $scheduledTime (ID: $notificationId)");
//     } catch (e) {
//       print("Failed to schedule ${prayer.name}: $e");
//     }
//   }

//   //! Debug:
//   final scheduledNotifications = await notificationPlugin.pendingNotificationRequests();
//   print("\n Scheduled Notifications Summary:");
//   for (var notification in scheduledNotifications) {
//     print("ID: ${notification.id} - ${notification.title}");
//   }
//   print("Total scheduled notifications: ${scheduledNotifications.length}\n");
// }

// //__________________________________________________________________
// // **Cancel All Notifications:

//   Future<void> cancelAllNotifications() async {
//     await notificationPlugin.cancelAll();
//   }

// //___________________________________________________________________
// //*Notify User to Enable Internet:

//   Future<void> notifyToEnableInternet() async {
//     await showNotification(
//       id: 9999, // Unique ID
//       title: "🔔 Update Needed!",
//       body: "Please enable the internet to refresh prayer times. 🌍",
//     );
//   }

// //*Show Immediate Notification
//   Future<void> showNotification(
//       {int id = 0, String? title, String? body}) async {
//     return notificationPlugin.show(id, title, body, notificationDetails());
//   }


// }
