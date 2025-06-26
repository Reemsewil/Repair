// class  FeatchProjectBloc extends Bloc<FeatchProjectEvent, FeatchProjectState> {
//   FeatchProjectBloc() : super(FeatchProjectInitialState()) {

//     on<FeatchProject>(
//       (event, emit) async {
//         print("kjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
//         // ! We Can Find The attribute of Event in the 'event' object
//         ResultModel result = await FeatchProjectSerivceImp().featchProject();
//         print("this is result is from project service ================================");
//         print(result);
//         if (result is ProjectInformationModelForFetchProject) {
//           emit((SuccessFeatchProjectState(featchedProject: result)));

//         } else {
//           emit(ErrorFetchProjectState(message: result.runtimeType.toString()));
//         }
//       },
//     );
//   }
// }

//   return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//             create: (context) => FeatchTasksBloc()..add(FeatchTasks())),
//         BlocProvider(
//           create: (context) => FeatchProjectBloc()..add(FeatchProject()),
//         )
//       ],

//////////////////////////////////////////

//  context.read<CreateProjectBloc>().add(CreateProject(
//                                       project: ProjectModel(
//                                           projectName: projectName.text,
//                                           projectDescription: projectScript.text,
//                                           projectStatus: "NEW")));

//            Spacer(),
//                   BlocConsumer<CreateProjectBloc, CreateProjectState>(

//    listener: (context, state) {
//                 if (state is SuccessCreateProjectState) {

// Navigator.push(context,MaterialPageRoute( builder: (context) => MyTasks(state.id),
//                               ),);       }
//               },

//                     builder: (context, state) {
//                            if (state is CreateProjectInitialState) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0),
//                         child: Center(
//                           child: Container(
//                               width: width / 1.1,
//                               height: height / 12,
//                               child: ElevatedButton(
//                                 onPressed: () async {
//                                   context.read<CreateProjectBloc>().add(CreateProject(
//                                       project: ProjectModel(
//                                           projectName: projectName.text,
//                                           projectDescription: projectScript.text,
//                                           projectStatus: "NEW")));
//                                 },

//    return BlocProvider(
//       create: (context) => CreateProjectBloc(),
//       child: Builder(builder: (context) {
//         return Scaffold(

import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:hive_flutter/hive_flutter.dart';

//import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'models/prayers/prayer_times.dart' as r;
import 'services/api/prayer_times.dart';

void loadData() async {
  try {
    PrayerTimesServiceImp service = PrayerTimesServiceImp();

    log("im in loaddatea");
    print("========================++++++++++reeeem===============");
    final response = await service.getPrayerTimes();
    log(response.data.prayerTimes.asr);

    log("Maraba");

    final apiPrayerTimes = response.data.prayerTimes;

    final hivePrayerTimes = r.PrayerTimes(
      fajr: apiPrayerTimes.fajr,
      sunrise: apiPrayerTimes.sunrise,
      dhuhr: apiPrayerTimes.dhuhr,
      asr: apiPrayerTimes.asr,
      sunset: apiPrayerTimes.sunset,
      maghrib: apiPrayerTimes.maghrib,
      isha: apiPrayerTimes.isha,
      imsak: apiPrayerTimes.imsak,
      midnight: apiPrayerTimes.midnight,
      firstthird: apiPrayerTimes.firstThird,
      lastthird: apiPrayerTimes.lastThird,
    );

    final prayerBox = Hive.box<r.PrayerTimes>('prayertimesbox');

    await prayerBox.put('today', hivePrayerTimes);
  } catch (e) {
    print("API call failed: $e");
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> initializeNotifications() async {
  try {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    final androidNotificationChannel = AndroidNotificationChannel(
      'prayer_channel',
      'Prayer Notifications',
      description: 'تذكير بمواقيت الصلاة اليومية',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);

    await scheduleDailyPrayerNotifications();
  } catch (e, stack) {
    print('🔥 Error during notification initialization: $e\n$stack');
  }
}

Future<void> scheduleDailyPrayerNotifications() async {
  final box = Hive.box<r.PrayerTimes>('prayertimesbox');
  final prayerTimes = box.get(
    'today',
  ); // Assuming you're storing under the key 'today'

  final prayers = <String, String>{
    "الفجر": prayerTimes!.fajr,
    "الظهر": prayerTimes.dhuhr,
    "العصر": prayerTimes.asr,
    "المغرب": prayerTimes.maghrib,
    "العشاء": prayerTimes.isha,
  };

  for (var entry in prayers.entries) {
    try {
      final timeParts = entry.value.split(":");
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        entry.key.hashCode,
        "موعد الصلاة",
        "حان الآن موعد صلاة ${entry.key}",
        _nextInstanceOf(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'prayer_channel',
            'Prayer Notifications',
            channelDescription: 'تذكير بمواقيت الصلاة اليومية',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e, stack) {
      print('🔥 Failed to schedule ${entry.key}: $e\n$stack');
    }
  }
}

tz.TZDateTime _nextInstanceOf(int hour, int minute) {
  final now = tz.TZDateTime.now(tz.local);
  var scheduled = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  ).add(const Duration(minutes: 5)); // 🔥 Add 5 minutes here

  if (scheduled.isBefore(now)) {
    scheduled = scheduled.add(const Duration(days: 1));
  }

  return scheduled;
}

// ** تم التعليق على خدمة الخلفية كاملة **
/*
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'prayer_channel',
      initialNotificationTitle: 'Najati App',
      initialNotificationContent: 'تشغيل في الخلفية لتذكير الصلاة',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(),
  );

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  tz.initializeTimeZones();
  await initializeNotifications();
  await scheduleDailyPrayerNotifications();
}
*/
