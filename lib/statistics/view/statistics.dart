// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najati_test/statistics/view/month.dart';
import 'package:najati_test/statistics/view/week.dart';
import 'package:najati_test/statistics/view/year.dart';

import '../../core/constants/color_manager.dart';
import '../../core/widgets/textfield_common.dart';
import '../../custom_widget.dart';
import '../../main.dart';
import '../../najati/notific_/view/notificate.dart';
import '../../najati/sonnan_/view/sonan.dart';
import '../bloc/bloc/statistic_bloc.dart';

// import 'package:najati_test/year.dart';

// import 'core/constants/image_manager.dart';
// import 'core/widgets/textfield_common.dart';
// import 'custom_widget.dart';
// import 'main.dart';
int currentWeek = 1;
int currentMonth = DateTime.now().month;

int currentYear = 2025;

class TopRightCircley extends StatelessWidget {
  TopRightCircley({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // خلي العرض والارتفاع متساويين عشان الدائرة تكون دائرية فعلاً
    final double size = screenW * 0.6;

    return Positioned(
      top: 20,
      right: -65,
      child: Opacity(
        opacity: 0.8,
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 199, 133, 250),
                  blurRadius: 70,
                ),
              ],
              shape: BoxShape.circle,
              color: Color(0xff9556C6).withOpacity(0.07),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenW * 0.06),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "الإحصائيات",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF32C9C4),
                      ),
                      height: screenH * 0.11,
                      width: screenW * 0.17,
                      child: Icon(Icons.abc_sharp),

                      // fit: BoxFit.contain,
                      // child: Image.network(
                      //   "${UrlManager.baseUrl}${child.character.image}",
                      //   color:
                      //       profileResponse!
                      //                   .data
                      //                   .paid ==
                      //               true
                      //           ? null
                      //           : ColorManager
                      //               .blackOverlay,
                      //   width: 40,
                      //   height: 40,
                      //   fit: BoxFit.cover,
                      //   errorBuilder: (
                      //     context,
                      //     error,
                      //     stackTrace,
                      //   ) {
                      //     return const Icon(
                      //       Icons.broken_image,
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Statistics extends StatefulWidget {
  Statistics({
    super.key,
    required this.childId,
    required this.nameChild,
    required this.imageChild,
  });
  int childId;
  String nameChild;
  String? imageChild;
  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  bool monthSelect = false;

  bool yearSelect = false;

  bool weekSelect = true;

  void increaseWeek() {
    if (weekSelect && currentWeek < 4) {
      setState(() {
        currentWeek++;
      });
    }
  }

  void decreaseWeek() {
    if (weekSelect && currentWeek > 1) {
      setState(() {
        currentWeek--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIncreaseDisabled = currentWeek == 4;
    final bool isDecreaseDisabled = currentWeek == 1;
    return BlocProvider(
      create:
          (context) =>
              StatisticBloc()
                ..add(GetWeak(id: widget.childId, currentWeek: currentWeek)),
      child: Builder(
        builder: (context) {
          return Scaffold(
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
                BlocBuilder<StatisticBloc, StatisticState>(
                  builder: (context, state) {
                    if (state is SuccessGetWeek) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: screenH * 0.3,
                            child: Container(
                              width: screenW * 0.88,
                              height: screenH * 0.43,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //  color: Colors.red,
                                    child: Row(
                                      children: [
                                        Text('الأسبوع ${currentWeek}'),
                                        Spacer(),
                                        //    Icon(Icons.more_vert),
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.more_vert),
                                          onSelected: (value) {
                                            log("hi ereenm");
                                            value == "week"
                                                ? weekSelect = true
                                                : value == "year"
                                                ? yearSelect = true
                                                : monthSelect = true;
                                            print('Selected: $value');
                                            (value == 'week')
                                                ? context
                                                    .read<StatisticBloc>()
                                                    .add(
                                                      GetWeak(
                                                        id: widget.childId,
                                                        currentWeek:
                                                            currentWeek,
                                                      ),
                                                    )
                                                : (value == 'year')
                                                ? context
                                                    .read<StatisticBloc>()
                                                    .add(
                                                      GetYear(
                                                        id: widget.childId,
                                                        currentYear:
                                                            currentYear,
                                                      ),
                                                    )
                                                : (value == 'month')
                                                ? context
                                                    .read<StatisticBloc>()
                                                    .add(
                                                      GetMonth(
                                                        id: widget.childId,
                                                        currentMonth:
                                                            currentMonth,
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
                                      ],
                                    ),
                                  ),
                                  //   const SizedBox(height: 8),
                                  Container(
                                    //      color: Colors.blue,
                                    height: screenH * 0.28,
                                    //width: screenW * 0.8,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: screenW * 0.08,
                                        left: screenW * 0.06,
                                      ),
                                      child: ListView.builder(
                                        itemCount: prayerNames.length,
                                        itemBuilder: (context, prayerIndex) {
                                          List<int?> prayerStatusAcrossWeek =
                                              List.generate(
                                                7,
                                                (dayIndex) =>
                                                    state
                                                        .week
                                                        .data
                                                        .days[dayIndex]
                                                        .prayers[prayerIndex]
                                                        .status,
                                              );
                                          return PrayerRow(
                                            statusList: prayerStatusAcrossWeek,

                                            prayerName:
                                                prayerNames[prayerIndex],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                                color: Color.fromARGB(
                                                  147,
                                                  229,
                                                  227,
                                                  231,
                                                ),
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
                                                color: Color.fromARGB(
                                                  148,
                                                  135,
                                                  95,
                                                  180,
                                                ),
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
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      weekSelect && !isIncreaseDisabled
                                          ? increaseWeek()
                                          : null;
                                      context.read<StatisticBloc>().add(
                                        GetWeak(
                                          id: widget.childId,
                                          currentWeek: currentWeek,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenW * 0.83),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      weekSelect && !isDecreaseDisabled
                                          ? decreaseWeek()
                                          : null;
                                      context.read<StatisticBloc>().add(
                                        GetWeak(
                                          id: widget.childId,
                                          currentWeek: currentWeek,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is SuccessGetMonth) {
                      int index = state.month.data.days.length - 1;
                      int indx =
                          state.month.data.days[index].prayers.length - 1;
                      return Month(
                        monthSelect: monthSelect,
                        status:
                            state.month.data.days[index].prayers[indx].status,
                        childId: widget.childId,
                      );
                    } else if (state is SuccessGetYear) {
                      return Year(
                        yearSelect: yearSelect,
                        childId: widget.childId,
                      );
                    } else {
                      return Container(
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                // yearSelect == true
                //     ? Year(yearSelect: true)
                //     : monthSelect == true
                //         ? Month(monthSelect: true)
                //         // : Week(weekSelect: true),
                //         : Year(yearSelect: true),
                Positioned(
                  right: 5,
                  top: screenH * 0.7,
                  // bottom: 20,
                  left: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenH * 0.07),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => Notifications(
                                      widget.nameChild,
                                      widget.imageChild,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            width: screenW * 0.88,
                            height: screenH * 0.07,
                            decoration: DecorationField.decorationContainer,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "الإشعارات",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: screenH * 0.15,
                                    width: screenW * 0.09,
                                    // fit: BoxFit.contain,
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => SunnahPrayers(
                                      widget.childId,
                                      widget.nameChild,
                                      widget.imageChild,
                                    ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: screenW * 0.88,
                              height: screenH * 0.07,
                              decoration: DecorationField.decorationContainer,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "إدراج السنن للبرنامج",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: screenH * 0.15,
                                      width: screenW * 0.09,
                                      // fit: BoxFit.contain,
                                      child: Icon(Icons.chevron_right),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenH * 0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PrayerRow extends StatelessWidget {
  final String prayerName;
  final List<int?> statusList;
  const PrayerRow({
    Key? key,
    required this.statusList,
    required this.prayerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;

    return Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: screenH * 0.03,
            //  width: screenW * 0.8,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: statusList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 7),
              itemBuilder: (context, index) => Square(color: statusList[index]),
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
  final int? color;
  const Square({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color:
            (color == null)
                ? Colors.grey.shade300
                : (color == 1)
                ? const Color(0xFF70DAD6)
                : const Color.fromARGB(148, 135, 95, 180),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
