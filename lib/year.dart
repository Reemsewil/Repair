import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';

import 'viewselector.dart';

class Year extends StatefulWidget {
  Year({super.key, required this.yearSelect});

  bool monthSelect = false;

  bool yearSelect;

  bool weekSelect = false;
  @override
  State<Year> createState() => _YearState();
}

class _YearState extends State<Year> {
  final List<String> prayerNames = const [
    "5",
    "4",
    "3",
    "2",
    "1",
    "5",
    "4",
    "3",
    "2",
    "1",
    "5",
    "4",
  ];

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
    final bool isDecreaseDisabled = currentYear == minYear;

    return Scaffold(
      //  appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: screenH * 0.2,
            child: Container(
              width: screenW * 0.91,
              height: screenH * 0.41,
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
                      Text("data"),
                      SizedBox(width: screenW * 0.68),
                      Icon(Icons.more_vert),
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
                    children: [],
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
                    onTap: increaseYear,

                    child: Icon(Icons.arrow_circle_up),
                  ),
                ),
                SizedBox(width: screenW * 0.83),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),

                  child: InkWell(
                    onTap: !isDecreaseDisabled ? decreaseYear : null,
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
