import 'package:flutter/material.dart';

class Week extends StatefulWidget {
  const Week({super.key});

  @override
  State<Week> createState() => _WeekState();
}
  final List<String> prayerNames = const ["فجر", "ظهر", "عصر", "مغرب", "عشاء"];

  bool monthSelect = false;

  bool yearSelect = false;

  bool weekSelect = true;

class _WeekState extends State<Week> {
  @override
  Widget build(BuildContext context) {
     double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Container(
      width: screenW * 0.91,
      height: screenH * 0.90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
            child: Row(
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
                  itemBuilder: (BuildContext context) => [
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
            color: Colors.blue,
            height: screenH * 0.28,
            // width: screenW * 0.8,
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
    );
  }
}
class PrayerRow extends StatelessWidget {
  final String prayerName;
  const PrayerRow({required this.prayerName, super.key});

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

