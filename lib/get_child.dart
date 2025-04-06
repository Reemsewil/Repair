import 'package:flutter/material.dart';
import 'package:najati_test/custom_widget.dart';
import 'package:najati_test/main.dart';
import 'package:najati_test/stack.dart';

import 'core/constants/image_manager.dart';

class GetChildren extends StatefulWidget {
  const GetChildren({super.key});

  @override
  State<GetChildren> createState() => _GetChildrenState();
}

class _GetChildrenState extends State<GetChildren> {
  bool displayCharachter = false;

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
            top: screenH * 0.14,
            bottom: 20,
            left: 5,
            child: Column(
              children: [
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenH * 0.08),
                Image.asset(
                  'assets/images/Boos.png',
                  height: screenH * 0.12,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenH * 0.06),
                InkWell(
                  onTap: () {
                    setState(() {
                      displayCharachter = true;
                    });
                  },
                  child: Container(
                    width: screenW * 0.88,
                    height: screenH * 0.1,
                    decoration: BoxDecoration(
                      color: Color(0x73C2CEE3).withOpacity(0.45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 18,
                          color: Color(0x73C2CEE3).withOpacity(0.45),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "hamza",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Image.asset(
                          ImageManager.noImage,
                          height: screenH * 0.12,
                          width: screenW * 0.06,
                          // fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
                //   SizedBox(height: screenH * 0.08),
                displayCharachter == true
                    ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenW * 0.1,
                              vertical: 12,
                            ),
                            child: Container(
                              child: Text(
                                "اختر شخصيتك المفضلة",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          StackList(),
                        ],
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
