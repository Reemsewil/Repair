import 'package:flutter/material.dart';
import 'package:najati_test/bubble.dart';
import 'package:najati_test/core/constants/image_manager.dart';
import 'package:najati_test/counter.dart';
import 'package:najati_test/ty.dart';

import 'core/constants/color_manager.dart';
import 'education.dart';
import 'main.dart';
import 'top_student.dart';

//   color:ColorManager.deepPurpleWithOpacity10,
//   boxShadow: [
//     BoxShadow(
//       color: ColorManager.deepPurpleWithOpacity70,
//       blurRadius: 20,
//       spreadRadius: 10,
//     ),
//   ],
// ),
// child: Container(
//   width: largeCircleSize * 0.68,
//   height: largeCircleSize * 0.68,
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     boxShadow: [
//       BoxShadow(
//         color:ColorManager.purpleAccentWithOpacity32,
//         blurRadius: 20,
//         spreadRadius: 2,
//       ),
//     ],
//   ),

// --- Custom Widget for the Top-Right Background Circle ---
class TopRightCircleChild extends StatelessWidget {
  TopRightCircleChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // خلي العرض والارتفاع متساويين عشان الدائرة تكون دائرية فعلاً
    final double size = screenW * 0.55;

    return Positioned(
      top: screenH * 0.01,
      right: -screenH * 0.1,
      child: Opacity(
        opacity: 0.8,
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Color(0xffD6A2FF), blurRadius: 70),
              ],
              shape: BoxShape.circle,
              color: Color(0xff9556C6).withOpacity(0.07),
            ),
            child: Transform.translate(
              offset: const Offset(0, 30), // 20 pixels down
              child: childImage(),
            ),
          ),
        ),
      ),
    );
  }
}

class TopRightCircle extends StatelessWidget {
  TopRightCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // خلي العرض والارتفاع متساويين عشان الدائرة تكون دائرية فعلاً
    final double size = screenW * 0.55;

    return Positioned(
      top: screenH * 0.01,
      right: -screenH * 0.1,
      child: Opacity(
        opacity: 0.8,
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Color(0xffD6A2FF), blurRadius: 70),
              ],
              shape: BoxShape.circle,
              color: Color(0xff9556C6).withOpacity(0.07),
            ),
          ),
        ),
      ),
    );
  }
}

class childImage extends StatelessWidget {
  const childImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageManager.secondchild, fit: BoxFit.cover);
  }
}

class TopRightCircleTasbeeh extends StatelessWidget {
  TopRightCircleTasbeeh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // خلي العرض والارتفاع متساويين عشان الدائرة تكون دائرية فعلاً
    final double size = screenW * 0.6;

    return Positioned(
      top: screenH * 0.01,
      right: -screenH * 0.08,
      child: Opacity(
        opacity: 0.8,
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Color(0xffD6A2FF), blurRadius: 70),
              ],
              shape: BoxShape.circle,
              color: Color(0xff9556C6).withOpacity(0.07),
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TasbeehImage(),
            ),
          ),
        ),
      ),
    );
  }
}

class TasbeehImage extends StatelessWidget {
  const TasbeehImage({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CounterWidget()),
        );
      },
      child: Row(
        children: [
          SizedBox(width: screenW * 0.03),
          FittedBox(
            fit: BoxFit.scaleDown,

            child: Image.asset(ImageManager.tasbeeh, width: 160, height: 160),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widget for the Left-Bottom Background Circle ---
class LeftBottomCircle extends StatelessWidget {
  const LeftBottomCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -screenW * 0.08,
      bottom: screenW * 0.5,
      child: Opacity(
        opacity: 0.4,
        child: Container(
          width: screenW * 0.3,
          height: screenH * 0.35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            boxShadow: [
              BoxShadow(
                color: ColorManager.darkOrangeWithOpcaity50,
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCircle extends StatelessWidget {
  const QuestionCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenW * 0.1,
      left: screenW * 0.09,
      child: Opacity(
        opacity: 0.8,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LearnTogetherScreen()),
            );
          },
          child: Container(
            width: screenW * 0.2,
            height: screenH * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 168, 151, 214),
                  //blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Image.asset(ImageManager.question),
          ),
        ),
      ),
    );
  }
}

class WinCircle extends StatelessWidget {
  WinCircle({Key? key, required this.childId}) : super(key: key);
  int childId;
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Positioned(
      top: screenH / 4,
      left: screenW / 6,
      child: Opacity(
        opacity: 0.6,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopStudent(childId: childId),
              ),
            );
          },
          child: Container(
            width: screenW * 0.15,
            height: screenH * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 165, 161, 173),
                  blurRadius: 6,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Image.asset(ImageManager.owner),
          ),
        ),
      ),
    );
  }
}

// --- Custom Widget for the Right-Bottom Background Circle ---
class RightBottomCircle extends StatelessWidget {
  const RightBottomCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: -screenW * 0.08,
      right: -screenH / 17,
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: screenW * 0.4,
          height: screenH * 0.21,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            // Adjusted alpha in hex for clarity (0x95 is hex for 149 decimal)
            // The original color(0xff955cbeb2) might have been a typo,
            // assuming alpha was intended. If 0xff was intended as alpha,
            // it means fully opaque, making Opacity useless.
            // Using 0x95 based on the opacity value. Change if needed.
            boxShadow: [
              BoxShadow(
                color: ColorManager.tealWithOpcaity50,
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
