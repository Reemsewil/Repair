import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najati_test/statistics/view/statistics.dart';

import '../../custom_widget.dart';
import '../bloc/bloc/statistic_bloc.dart';
import 'week.dart';

// import 'package:najati_test/main.dart';

// import 'viewselector.dart';

class Year extends StatefulWidget {
  Year({super.key, required this.yearSelect, required this.childId});
  int childId;
  bool monthSelect = false;

  bool yearSelect;

  bool weekSelect = false;

  @override
  State<Year> createState() => _YearState();
}

int currentWeek = 0;

class _YearState extends State<Year> {
  final List<String> prayerNames = const [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ];
  int currentMonth = 0;
  int currentYear = 2025;

  final int minYear = 2025;

  void increaseYear() {
    setState(() {
      currentYear++;
    });
  }

  void decreaseYear() {
    if (currentYear > minYear) {
      setState(() {
        currentYear--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    final bool isDecreaseDisabled = currentYear == minYear;

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
                      Text("إحصائيات"),
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
                                    currentMonth: currentMonth,
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
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PrayerRow(prayerName: prayerNames[index]),
                            ],
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
                        increaseYear;
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
                      !isDecreaseDisabled ? decreaseYear : null;
                      context.read<StatisticBloc>().add(
                        GetYear(id: widget.childId, currentYear: currentYear),
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
  const PrayerRow({required this.prayerName, super.key});

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

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
              itemCount: 365,
              separatorBuilder: (_, __) => const SizedBox(width: 3),
              itemBuilder: (_, __) => const Square(),
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
  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
        //borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class YearView extends StatelessWidget {
  final List<String> prayerNames;
  final String selectedView;
  final Function(String) onViewChanged;

  const YearView({
    super.key,
    required this.prayerNames,
    required this.selectedView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            const Text("عرض أسبوعي"),
            const Spacer(),
            // ViewSelector(selectedView: selectedView, onSelected: onViewChanged),
          ],
        ),
        SizedBox(
          height: screenH * 0.28,
          //width: screenW * 0.8,
          child: Padding(
            padding: EdgeInsets.only(
              right: screenW * 0.03,
              left: screenW * 0.02,
            ),
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return Column(
                  children: [PrayerRow(prayerName: prayerNames[index])],
                );
              },
            ),
          ),
        ),
        Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: []),
      ],
    );
  }
}
