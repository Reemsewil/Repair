// import 'package:flutter/material.dart';
// import 'package:najati_test/main.dart';

// import 'viewselector.dart';

// class Month extends StatefulWidget {
//   Month({super.key, required this.monthSelect});

//   bool monthSelect;

//   bool yearSelect = false;

//   bool weekSelect = false;
//   @override
//   State<Month> createState() => _MonthState();
// }

// class _MonthState extends State<Month> {
//   final List<String> prayerNames = const ["فجر", "ظهر", "عصر", "مغرب", "عشاء"];

//   int currentMonthNumber = 6;

//   String getMonthLabel(int number) {
//     // الرقم يبدأ من 1 وليس صفر
//     int index = (number - 1) % 12;
//     if (index < 0) index += 12;
//     return arabicMonthNumbers[index];
//   }

//   void increaseMonth() {
//     setState(() {
//       currentMonthNumber++;
//     });
//   }

//   void decreaseMonth() {
//     setState(() {
//       currentMonthNumber--;
//     });
//   }

//   final List<String> arabicMonthNumbers = [
//     'الأول',
//     'الثاني',
//     'الثالث',
//     'الرابع',
//     'الخامس',
//     'السادس',
//     'السابع',
//     'الثامن',
//     'التاسع',
//     'العاشر',
//     'الحادي عشر',
//     'الثاني عشر',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     String displayText = 'الشهر ${getMonthLabel(currentMonthNumber)}';

//     return Scaffold(
//       //  appBar: AppBar(),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             top: screenH * 0.2,
//             child: Container(
//               width: screenW * 0.91,
//               height: screenH * 0.41,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text("data"),
//                       SizedBox(width: screenW * 0.68),
//                       Icon(Icons.more_vert),
//                     ],
//                   ),
//                   //   const SizedBox(height: 8),
//                   SizedBox(
//                     height: screenH * 0.28,
//                     //width: screenW * 0.8,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: screenW * 0.03,
//                         left: screenW * 0.02,
//                       ),
//                       child: ListView.builder(
//                         itemCount: prayerNames.length,
//                         itemBuilder: (context, index) {
//                           return PrayerRow(prayerName: prayerNames[index]);
//                         },
//                       ),
//                     ),
//                   ),
//                   Divider(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: [
//                           Text("لم تُقضَ"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 20,
//                               width: 20,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromARGB(147, 229, 227, 231),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text("قضاء"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 20,
//                               width: 20,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color.fromARGB(148, 135, 95, 180),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       Row(
//                         children: [
//                           Text("حاضر"),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 20,
//                               width: 20,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Color(0xFF70DAD6),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: screenH * 0.4,
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: InkWell(
//                     onTap: increaseMonth,

//                     child: Icon(Icons.arrow_circle_up),
//                   ),
//                 ),
//                 SizedBox(width: screenW * 0.83),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),

//                   child: InkWell(
//                     onTap: decreaseMonth,

//                     child: Icon(Icons.arrow_circle_down),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PrayerRow extends StatelessWidget {
//   final String prayerName;
//   const PrayerRow({required this.prayerName, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       //   mainAxisAlignment: MainAxisAlignment.center,
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: screenW * 0.03,
//             //  width: screenW * 0.8,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: 30,
//               separatorBuilder: (_, __) => const SizedBox(width: 3),
//               itemBuilder: (_, __) => const Square(),
//             ),
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(9.0),
//           child: Text(prayerName, style: const TextStyle(fontSize: 12)),
//         ),
//       ],
//     );
//   }
// }

// class Square extends StatelessWidget {
//   const Square({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 10,
//       width: 10,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade300,
//         shape: BoxShape.circle,
//         //borderRadius: BorderRadius.circular(6),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Center(child: Text("لا يوجد لديك إشعارات ")),
      ),
    );
  }
}
