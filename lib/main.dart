import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:najati_test/core/constants/image_manager.dart';
import 'package:najati_test/counter.dart';
import 'package:najati_test/features/verify2.dart';
import 'package:najati_test/settings.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:path_provider/path_provider.dart';
import 'package:najati_test/get_child.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:najati_test/services/noti_service.dart';
//import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:najati_test/verify.dart';
import 'clip.dart';
import 'container_week.dart';
import 'dio_interceptor.dart';
import 'models/attendances/attendance_hive_model.dart';
import 'models/attendances/send_prayer_status_response.dart';
import 'models/prayers/prayer_times.dart' as r;
import 'bubble.dart';
//import 'clip.dart';
import 'create_child.dart';
import 'education.dart';
import 'models/prayers/prayer_times.dart';
import 'najati.postman_collection.dart';
import 'najati/sonnan_/view/sonan.dart';
import 'register.dart';
import 'select_story.dart';
import 'smile.dart';
import 'statistics/view/statistics.dart';
import 'top_student.dart';

//final bool hasToken = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  //Bloc.observer = MyBlocObserver();
  if (!Hive.isBoxOpen('authBox')) {
    await Hive.openBox('authBox');
  }

  Hive.registerAdapter(PrayerTimesAdapter());
  await Hive.openBox<r.PrayerTimes>('prayertimesbox');
  await Hive.openBox<AttendancesRequest>('attendPrayer');
  Hive.registerAdapter(AttendanceAdapter());

  await Hive.openBox<Attendance>('attendanceBox');

  //final authBox = Hive.box('authBox');
  // final hasToken = authBox.get('accessToken') != null;
  try {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    await initializeNotifications();
  } catch (e, stack) {
    print('🔥 Error during main initialization: $e\n$stack');
  }
  final authBox = Hive.box('authBox');

  final token = authBox.get('accessToken');
  DioClient.init();

  runApp(MyApp(hasToken: token != null && token.toString().isNotEmpty));
}

late double screenW;
late double screenH;

class MyApp extends StatelessWidget {
  final bool hasToken;

  const MyApp({super.key, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.sizeOf(context).width;
    screenH = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFDEE9FD),
          canvasColor: const Color(0xFFDEE9FD),
        ),
        home: hasToken ? GetChildren("") : Register(),
        // SunnahPrayers(1, "jhdhdjdj", null),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// // home: hasToken ? GetChildrenScreen() : RegisterScreen(),
// final attendanceBox = Hive.box<Attendance>('attendanceBox');

// // Create a new attendance object
// final attendance = Attendance(
//   childId: 1,
//   prayerId: 3,
//   status: 1,
//   datetime: DateTime.now(),
// );

// // Save it (auto-increments the key)
// await attendanceBox.add(attendance);

// // Or save with custom key (e.g., using combination string)
// await attendanceBox.put('1-3', attendance); // e.g., 'childId-prayerId'





// // await attendanceBox.clear(); // delete all


// final attendanceBox = Hive.box<Attendance>('attendanceBox');

// List<Attendance> allAttendances = attendanceBox.values.toList();

// for (var item in allAttendances) {
//   print('${item.childId}, ${item.prayerId}, ${item.status}, ${item.datetime}');
// }

