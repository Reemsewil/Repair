import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/image_manager.dart';

import 'core/constants/color_manager.dart';
import 'custom_widget.dart';
import 'main.dart';

class Smile extends StatelessWidget {
  const Smile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopRightCircle(),
          LeftBottomCircle(),
          RightBottomCircle(),

          Positioned(
            right: 5,
            top: screenH * 0.12,
            bottom: 22,
            left: 5,

            child: Container(
              width: screenW * 0.4,
              height: screenH * 0.25,
              decoration: BoxDecoration(
                color: ColorManager.container1Color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, style: BorderStyle.solid),
                gradient: ColorManager.container1BorderGradient,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: screenW * 0.33,
                  height: screenH * 0.22,
                  decoration: BoxDecoration(
                    gradient: ColorManager.container2BackgroundGradient,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: screenW * 0.25,
                      height: screenH * 0.17,
                      decoration: BoxDecoration(
                        color: ColorManager.container3Color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, style: BorderStyle.solid),
                        gradient: ColorManager.container3BorderGradient,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2F2C36).withOpacity(0.5),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: Center(
                        child: ShaderMask(
                          shaderCallback:
                              (bounds) => LinearGradient(
                                colors: [Color(0xFF284273), Color(0xFF5280D4)],
                              ).createShader(bounds),
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(ImageManager.smile),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//import 'package:flutter/material.dart';

// import 'core/constants/image_manager.dart';
// import 'core/widgets/textfield_common.dart';
// import 'custom_widget.dart';
// import 'main.dart';

// class Statistics extends StatefulWidget {
//   const Statistics({super.key});

//   @override
//   State<Statistics> createState() => _StatisticsState();
// }

// class _StatisticsState extends State<Statistics> {
//   final List<String> prayerNames = const ["فجر", "ظهر", "عصر", "مغرب", "عشاء"];

//   bool monthSelect = false;

//   bool yearSelect = false;

//   bool weekSelect = false;

//   int currentWeek = 1;

//   void increaseWeek() {
//     if (weekSelect && currentWeek < 4) {
//       setState(() {
//         currentWeek++;
//       });
//     }
//   }

//   void decreaseWeek() {
//     if (weekSelect && currentWeek > 0) {
//       setState(() {
//         currentWeek--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isIncreaseDisabled = currentWeek == 4;
//     final bool isDecreaseDisabled = currentWeek == 0;
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           TopRightCircle(),
//           LeftBottomCircle(),
//           RightBottomCircle(),

//           Positioned(
//             top: screenH * 0.3,
//             child: Container(
//               width: screenW * 0.91,
//               height: screenH * 0.45,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     color: Colors.red,
//                     child: Row(
//                       children: [
//                         Text("data"),
//                         SizedBox(width: screenW * 0.62),
//                         //    Icon(Icons.more_vert),
//                         PopupMenuButton<String>(
//                           icon: const Icon(Icons.more_vert),
//                           onSelected: (value) {
//                             value == "week"
//                                 ? weekSelect = true
//                                 : value == "year"
//                                 ? yearSelect = true
//                                 : monthSelect = true;
//                             print('Selected: $value');
//                             // e.g. update state or call a function based on the selection
//                           },
//                           itemBuilder:
//                               (BuildContext context) => [
//                                 const PopupMenuItem<String>(
//                                   value: 'week',
//                                   child: Text('أسبوع'),
//                                 ),
//                                 const PopupMenuItem<String>(
//                                   value: 'month',
//                                   child: Text('شهر'),
//                                 ),
//                                 const PopupMenuItem<String>(
//                                   value: 'year',
//                                   child: Text('سنة'),
//                                 ),
//                               ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   //   const SizedBox(height: 8),
//                   Container(
//                     color: Colors.blue,
//                     height: screenH * 0.28,
//                     //width: screenW * 0.8,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: screenW * 0.08,
//                         left: screenW * 0.06,
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
//                     onTap:
//                         weekSelect && !isIncreaseDisabled ? increaseWeek : null,
//                     child: Icon(
//                       Icons.arrow_circle_up,
//                       color: isIncreaseDisabled ? Colors.grey : Colors.blue,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenW * 0.83),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: InkWell(
//                     onTap:
//                         weekSelect && !isDecreaseDisabled ? decreaseWeek : null,

//                     child: Icon(
//                       Icons.arrow_circle_down,
//                       color: isDecreaseDisabled ? Colors.grey : Colors.red,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Positioned(
//             right: 5,
//             top: screenH * 0.7,
//             bottom: 20,
//             left: 5,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(height: screenH * 0.08),

//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Statistics()),
//                       );
//                     },
//                     child: Container(
//                       width: screenW * 0.88,
//                       height: screenH * 0.07,
//                       decoration: DecorationField.decorationContainer,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "الإشعارات",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Container(
//                               height: screenH * 0.15,
//                               width: screenW * 0.09,
//                               // fit: BoxFit.contain,
//                               child: Icon(Icons.arrow_back),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Statistics()),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: screenW * 0.88,
//                         height: screenH * 0.07,
//                         decoration: DecorationField.decorationContainer,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "إدراج السنن للبرنامج",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: Container(
//                                 height: screenH * 0.15,
//                                 width: screenW * 0.09,
//                                 // fit: BoxFit.contain,
//                                 child: Icon(Icons.stacked_line_chart_rounded),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Statistics()),
//                       );
//                     },
//                     child: Container(
//                       width: screenW * 0.88,
//                       height: screenH * 0.07,
//                       decoration: DecorationField.decorationContainer,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               "الشخصيات و السمات",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Container(
//                               height: screenH * 0.15,
//                               width: screenW * 0.09,
//                               // fit: BoxFit.contain,
//                               child: Icon(Icons.stacked_line_chart_rounded),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenH * 0.3),
//                 ],
//               ),
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
//             height: screenH * 0.03,
//             //  width: screenW * 0.8,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: 7,
//               separatorBuilder: (_, __) => const SizedBox(width: 7),
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
//       height: 22,
//       width: 22,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(6),
//       ),
//     );
//   }
// }
