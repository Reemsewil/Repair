import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';

class Week extends StatefulWidget {
  Week({super.key, required bool weekSelect});

  @override
  State<Week> createState() => _WeekState();
}

class _WeekState extends State<Week> {
  final List<String> prayerNames = const ["فجر", "ظهر", "عصر", "مغرب", "عشاء"];

  bool monthSelect = false;

  bool yearSelect = false;

  bool weekSelect = false;

  int currentWeek = 1;

  void increaseWeek() {
    if (weekSelect && currentWeek < 4) {
      setState(() {
        currentWeek++;
      });
    }
  }

  void decreaseWeek() {
    if (weekSelect && currentWeek > 0) {
      setState(() {
        currentWeek--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIncreaseDisabled = currentWeek == 4;
    final bool isDecreaseDisabled = currentWeek == 0;
    return Scaffold(
      //  appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: screenH * 0.2,
            child: Container(
              width: screenW * 0.91,
              height: screenH * 0.45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("data"),
                      SizedBox(width: screenW * 0.62),
                      //    Icon(Icons.more_vert),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          value == "week"
                              ? weekSelect = true
                              : value == "year"
                              ? yearSelect = true
                              : monthSelect = true;
                          print('Selected: $value');
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
                  //   const SizedBox(height: 8),
                  SizedBox(
                    height: screenH * 0.28,
                    //width: screenW * 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenW * 0.08,
                        left: screenW * 0.06,
                      ),
                      child: ListView.builder(
                        itemCount: prayerNames.length,
                        itemBuilder: (context, index) {
                          return PrayerRow(prayerName: prayerNames[index]);
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
            top: screenH * 0.4,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap:
                        weekSelect && !isIncreaseDisabled ? increaseWeek : null,
                    child: Icon(
                      Icons.arrow_circle_up,
                      color: isIncreaseDisabled ? Colors.grey : Colors.blue,
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
                    onTap:
                        weekSelect && !isDecreaseDisabled ? decreaseWeek : null,

                    child: Icon(
                      Icons.arrow_circle_down,
                      color: isDecreaseDisabled ? Colors.grey : Colors.red,
                    ),
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
    return Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: screenW * 0.06,
            //  width: screenW * 0.8,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              separatorBuilder: (_, __) => const SizedBox(width: 7),
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
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}




// class Square extends StatelessWidget {
//   final Color color;
//   const Square({required this.color, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 22,
//       width: 22,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(6),
//       ),
//     );
//   }
// }


// class PrayerRow extends StatelessWidget {
//   final String prayerName;
//   final List<Color> squareColors;

//   const PrayerRow({
//     required this.prayerName,
//     required this.squareColors,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: screenW * 0.06,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: squareColors.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 7),
//               itemBuilder: (context, index) => Square(color: squareColors[index]),
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



// List<Color> getPrayerColors(List<DayStats> days, int prayerId) {
//   return days.map((day) {
//     final prayer = day.prayers.firstWhere((p) => p.prayerId == prayerId);
//     if (prayer.status == null) {
//       return const Color.fromARGB(147, 229, 227, 231); // لم تُقضَ
//     } else if (prayer.status == 'qada') {
//       return const Color.fromARGB(148, 135, 95, 180); // قضاء
//     } else {
//       return const Color(0xFF70DAD6); // حاضر
//     }
//   }).toList();
// }




//  final List<String> prayerNames = ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
// final List<int> prayerIds = [1, 2, 3, 4, 5];


//  ListView.builder(
//   itemCount: prayerNames.length,
//   itemBuilder: (context, index) {
//     return PrayerRow(
//       prayerName: prayerNames[index],
//       squareColors: getPrayerColors(weeklyStats.days, prayerIds[index]),
//     );
//   },
// )
