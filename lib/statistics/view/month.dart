// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najati_test/statistics/view/statistics.dart';

import '../../../../models/week.dart';
import '../../custom_widget.dart';
import '../../main.dart';
import '../bloc/bloc/statistic_bloc.dart';
import 'week.dart';

// import 'viewselector.dart';

class Month extends StatefulWidget {
  Month({
    super.key,
    required this.monthSelect,
    required this.status,
    required this.childId,
  });
  int? status;
  bool monthSelect;
  int currenWeek = 0;
  int childId;
  bool yearSelect = false;

  bool weekSelect = false;
  @override
  State<Month> createState() => _MonthState();
}

class _MonthState extends State<Month> {
  final List<int> prayerIds = [1, 2, 3, 4, 5];
  ValueNotifier<int> currentMonthNumber = ValueNotifier(DateTime.now().month);

  int currentYear = DateTime.now().year;
  String getMonthLabel(int number) {
    // الرقم يبدأ من 1 وليس صفر
    int index = (number - 1) % 12;
    if (index < 0) index += 12;
    return arabicMonthNumbers[index];
  }

  void increaseMonth() {
    if (monthSelect && currentMonthNumber.value < 12) {
      currentMonthNumber.value++;
    }
  }

  void decreaseMonth() {
    currentMonthNumber.value =
        currentMonthNumber.value == 1 ? 12 : currentMonthNumber.value - 1;

    log("Decreased to month: ${currentMonthNumber.value}");
  }

  final List<String> arabicMonthNumbers = [
    'الأول',
    'الثاني',
    'الثالث',
    'الرابع',
    'الخامس',
    'السادس',
    'السابع',
    'الثامن',
    'التاسع',
    'العاشر',
    'الحادي عشر',
    'الثاني عشر',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMonthIncreaseDisabled = currentMonthNumber.value == 12;
    final bool isMonthDecreaseDisabled = currentMonthNumber.value == 1;

    return Scaffold(
      //  appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          TopRightCircley(),
          LeftBottomCircle(),
          RightBottomCircle(),
          Positioned(
            top: screenH * 0.15,
            //right: 5,
            left: screenW * 0.03,
            child: Icon(Icons.chevron_left),
          ),
          Positioned(
            top: screenH * 0.3,
            child: Container(
              width: screenW * 0.91,
              height: screenH * 0.45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: currentMonthNumber,
                        builder: (context, currentMonth, _) {
                          return Text(
                            "الشهر ${getMonthLabel(currentMonthNumber.value)}",
                          );
                        },
                      ),
                      Spacer(),
                      BlocProvider(
                        create: (context) => StatisticBloc(),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            value == "week"
                                ? weekSelect = true
                                : value == "year"
                                ? yearSelect = true
                                : monthSelect = true;
                            print('Selected: $value');
                            (value == 'week')
                                ? context.read<StatisticBloc>().add(
                                  GetWeak(
                                    id: widget.childId,
                                    currentWeek: currentWeek,
                                  ),
                                )
                                : (value == 'year')
                                ? context.read<StatisticBloc>().add(
                                  GetYear(
                                    id: widget.childId,
                                    currentYear: currentYear,
                                  ),
                                )
                                : (value == 'month')
                                ? context.read<StatisticBloc>().add(
                                  GetMonth(
                                    id: widget.childId,
                                    currentMonth: currentMonthNumber.value,
                                  ),
                                )
                                : null;
                            // e.g. update state or call a function based on the selection
                          },
                          itemBuilder:
                              (BuildContext context) => [
                                const PopupMenuItem<String>(
                                  value: 'week',
                                  child: Text('أسبوع'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'month',
                                  child: Text('شهر'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'year',
                                  child: Text('سنة'),
                                ),
                              ],
                        ),
                      ),
                    ],
                  ),
                  //   const SizedBox(height: 8),
                  SizedBox(
                    height: screenH * 0.28,
                    //width: screenW * 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenW * 0.03,
                        left: screenW * 0.02,
                      ),
                      child: ListView.builder(
                        itemCount: prayerNames.length,
                        itemBuilder: (context, index) {
                          return PrayerRow(
                            status: widget.status,
                            prayerName: prayerNames[index],
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text("لم تُقضَ"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(147, 229, 227, 231),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("قضاء"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(148, 135, 95, 180),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("حاضر"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF70DAD6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: screenH * 0.5,
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: BlocProvider(
                    create: (context) => StatisticBloc(),
                    child: InkWell(
                      onTap: () {
                        isMonthIncreaseDisabled ? null : increaseMonth();
                        log(
                          "iam in currentMonthNumber and ${currentMonthNumber.value} ",
                        );
                        log("increase");
                        context.read<StatisticBloc>().add(
                          GetMonth(
                            id: widget.childId,
                            currentMonth: currentMonthNumber.value,
                          ),
                        );
                      },
                      child: Icon(Icons.chevron_left),
                    ),
                  ),
                ),
                SizedBox(width: screenW * 0.83),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      isMonthDecreaseDisabled ? null : decreaseMonth();
                      context.read<StatisticBloc>().add(
                        GetMonth(
                          id: widget.childId,
                          currentMonth: currentMonthNumber.value,
                        ),
                      );
                    },
                    child: Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrayerRow extends StatelessWidget {
  final String prayerName;
  final int? status;
  const PrayerRow({Key? key, required this.prayerName, required this.status})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: screenW * 0.03,
            //  width: screenW * 0.8,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              separatorBuilder: (_, __) => const SizedBox(width: 3),
              itemBuilder: (_, __) => Square(statusPrayer: status),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(prayerName, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}

class Square extends StatelessWidget {
  final int? statusPrayer;
  const Square({Key? key, required this.statusPrayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color:
            (statusPrayer == null)
                ? Colors.grey.shade300
                : (statusPrayer == 1)
                ? const Color(0xFF70DAD6)
                : const Color.fromARGB(148, 135, 95, 180),
        shape: BoxShape.circle,
        //borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

// class MonthView extends StatelessWidget {
//   final List<String> prayerNames;
//   final int? status;
//   final String selectedView;
//   final Function(String) onViewChanged;
//   final String statusPrayer;

//   const MonthView({
//     Key? key,
//     required this.prayerNames,
//     this.status,
//     required this.selectedView,
//     required this.onViewChanged,
//     required this.statusPrayer,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text("data"),
//             SizedBox(width: screenW * 0.68),
//             Icon(Icons.more_vert),
//           ],
//         ),
//         //   const SizedBox(height: 8),
//         SizedBox(
//           height: screenH * 0.28,
//           //width: screenW * 0.8,
//           child: Padding(
//             padding: EdgeInsets.only(
//               right: screenW * 0.03,
//               left: screenW * 0.02,
//             ),
//             child: ListView.builder(
//               itemCount: prayerNames.length,
//               itemBuilder: (context, index) {
//                 return PrayerRow(
//                   status: status,
//                   prayerName: prayerNames[index],
//                 );
//               },
//             ),
//           ),
//         ),
//         Divider(),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               children: [
//                 Text("لم تُقضَ"),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 20,
//                     width: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color:
//                           (statusPrayer == 'null')
//                               ? const Color.fromARGB(147, 229, 227, 231)
//                               : (statusPrayer == 'ed')
//                               ? const Color.fromARGB(148, 135, 95, 180)
//                               : const Color(0xFF70DAD6),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 const Text("قضاء"),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 20,
//                     width: 20,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color.fromARGB(148, 135, 95, 180),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text("حاضر"),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 20,
//                     width: 20,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color(0xFF70DAD6),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

List<Color> getPrayerColors(List<DayStats> days, int prayerId) {
  return days.map((day) {
    final prayer = day.prayers.firstWhere((p) => p.prayerId == prayerId);
    if (prayer.status == 1) {
      return const Color(0xFF70DAD6);
    } else if (prayer.status == 2 || prayer.status == 3) {
      return const Color.fromARGB(148, 135, 95, 180); // قضاء
    } else {
      return const Color.fromARGB(147, 229, 227, 231); // لم تُقضَ
    }
  }).toList();
}
