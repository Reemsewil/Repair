import 'package:flutter/material.dart';

import 'core/constants/color_manager.dart';
import 'core/constants/image_manager.dart';
import 'custom_widget.dart';
import 'main.dart';
import 'stack.dart';

class LearnTogetherScreen extends StatefulWidget {
  LearnTogetherScreen({super.key});

  @override
  State<LearnTogetherScreen> createState() => _LearnTogetherScreenState();
}

class _LearnTogetherScreenState extends State<LearnTogetherScreen> {
  bool openCharachter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FB),
      body: Stack(
        children: [
          TopRightCircle(),
          LeftBottomCircle(),
          RightBottomCircle(),

          // Top-left gear icon
          Positioned(
            top: 40,
            left: 20,
            child: Icon(
              Icons.settings,
              color: ColorManager.deepPurple,
              size: 28,
            ),
          ),

          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //  const SizedBox(height: 40),

              // Title
              Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Text(
                  "لنتعلم معاً",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              SizedBox(height: screenH * 0.1),

              // Row of learning cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          openCharachter = true;
                        });
                      },
                      child: LearningCard(
                        imagePath: ImageManager.prayer,
                        label: 'الصلاة',
                      ),
                    ),
                    LearningCard(
                      imagePath: ImageManager.prayer,
                      label: 'الوضوء',
                    ),
                  ],
                ),
              ),
              openCharachter ? Text("سنتعلم الوضوء مع ") : Text(""),
              openCharachter
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

          // "m" speech-bubble avatar
        ],
      ),
    );
  }
}

class LearningCard extends StatelessWidget {
  final String imagePath;
  final String label;

  const LearningCard({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF95D1C8),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
