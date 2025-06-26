import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/image_manager.dart';

import 'custom_widget.dart';
import 'main.dart';
import 'models/top_student.dart/top.dart';
import 'services/api/leader_board.dart';

class TopStudent extends StatefulWidget {
  TopStudent({super.key, required this.childId});
  int childId;
  @override
  State<TopStudent> createState() => _TopStudentState();
}

class _TopStudentState extends State<TopStudent> {
  TextStyle tt = TextStyle(
    color: Color.fromARGB(255, 54, 49, 104),
    fontWeight: FontWeight.w800,
  );
  TextStyle ntt = TextStyle(
    fontSize: 22,
    color: Color.fromARGB(255, 54, 49, 104),
    fontWeight: FontWeight.bold,
  );
  LeaderboardResponse? leaderboardResponse;
  List<Child> children = [];
  bool isLoading = true; // حالة التحميل
  // Declare at class level
  @override
  void initState() {
    super.initState();
    getLeaderboardData();
  }

  void getLeaderboardData() async {
    try {
      LeaderboardService see = LeaderboardService();
      leaderboardResponse = await see.getLeaderboard(widget.childId);

      children =
          leaderboardResponse?.data.leaderboard.map((e) => e.child).toList() ??
          [];

      if (children.isEmpty) {
        // بعد أول فريم، أرجع للصفحة السابقة
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("لا يوجد بيانات للوحة الشرف لهذا الطفل."),
              duration: Duration(seconds: 3),
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
        return;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pop(context);
      // });
    }
  }

  Child getChildOrPlaceholder(int index) {
    if (index < children.length) {
      return children[index];
    } else {
      return Child(id: 0, name: '---', gender: '', points: 0, birthDate: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (children.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            "لا يوجد أطفال",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          TopRightCircleChild(),
          // childImage(),
          LeftBottomCircle(),
          RightBottomCircle(),
          //  childImage(),
          WinCircle(childId: widget.childId),
          QuestionCircle(),
          Positioned(
            right: 5,
            top: screenH * 0.38,
            bottom: 20,
            left: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // First stack - third child (index 2)
                    buildLeaderboardStack(
                      child: getChildOrPlaceholder(2),
                      rank: 3,
                      screenW: screenW,
                      screenH: screenH,
                      nameStyle: tt,
                      rankStyle: ntt,
                    ),

                    // Second stack - first child (index 0)
                    buildLeaderboardStack(
                      child: getChildOrPlaceholder(0),
                      rank: 1,
                      screenW: screenW,
                      screenH: screenH,
                      nameStyle: tt,
                      rankStyle: ntt,
                      isMiddle: true, // to handle different styling if needed
                    ),

                    // Third stack - second child (index 1)
                    buildLeaderboardStack(
                      child: getChildOrPlaceholder(1),
                      rank: 2,
                      screenW: screenW,
                      screenH: screenH,
                      nameStyle: tt,
                      rankStyle: ntt,
                    ),
                  ],
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenW * 0.05,
                      right: screenW * 0.05,
                      bottom: screenW * 0.02,
                    ),
                    child: Text(
                      "مرتبتي",
                      textAlign: TextAlign.right,
                      style: tt,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(148, 155, 218, 226),

                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: screenH * 0.07,
                  width: screenW * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Container(
                          child: Image.asset(ImageManager.bronzie),
                        ),
                      ),
                      //  Container(child: Image.asset(ImageManager.bronzie)),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" ريم امين", style: tt),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 45,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 45,
                                  height: 60,
                                  child: Image.asset(ImageManager.firstchild),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenH * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildLeaderboardStack({
  required Child child,
  required int rank,
  required double screenW,
  required double screenH,
  required TextStyle nameStyle,
  required TextStyle rankStyle,
  bool isMiddle = false, // to handle different size or layout if needed
}) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      Container(
        width: isMiddle ? screenW * 0.29 : screenW * 0.31,
        height: isMiddle ? screenH * 0.35 : screenH * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isMiddle ? Radius.zero : Radius.circular(12),
            bottomRight:
                isMiddle
                    ? Radius.zero
                    : (rank == 2 ? Radius.circular(12) : Radius.zero),
          ),
          color: Colors.deepPurple.withAlpha(
            isMiddle ? 70 : (rank == 3 ? 88 : 100),
          ),
        ),
      ),
      Positioned(
        top: -29,
        left: screenW * 0.03,
        bottom: isMiddle ? screenH / 3 : screenH * 0.26,
        child: Stack(
          children: [
            if (isMiddle)
              Row(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416), // 180 degrees
                    child: Image.asset(ImageManager.food, fit: BoxFit.cover),
                  ),
                  Image.asset(ImageManager.food, fit: BoxFit.cover),
                ],
              ),
            Container(
              height: screenH * 0.2,
              width: screenW * 0.24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
            ),
            Positioned(
              top: -8,
              left: screenW * 0.08,
              child: Container(
                height: screenH * 0.1,
                width: screenW * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageManager.firstchild),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: screenH * 0.04,
        child: Text(
          rank.toString(),
          style: rankStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Positioned(
        top: screenH * 0.12,
        child: Text(
          child.name.isNotEmpty ? child.name : "---",
          style: nameStyle,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

// This will get child at index if exists, else return placeholder
