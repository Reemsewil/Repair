import 'package:flutter/material.dart';

import 'core/constants/color_manager.dart';

// --- Custom Widget for the Top-Right Background Circle ---
class TopRightCircle extends StatelessWidget {
  const TopRightCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;

    return Positioned(
      top: 40,
      right: -65,
      child: Opacity(
        opacity: 0.7,
        // Removed the extra Center as Container is already positioning
        child: Container(
          width: screenW * 0.5,
          height: screenH * 0.28,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorManager.deepPurple,
            // Consider using theme colors
            boxShadow: [BoxShadow(blurRadius: 70)],
          ),
        ),
      ),
    );
  }
}

// --- Custom Widget for the Left-Bottom Background Circle ---
class LeftBottomCircle extends StatelessWidget {
  const LeftBottomCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;

    return Positioned(
      left: -40,
      bottom: 170,
      child: Opacity(
        opacity: 0.4,
        child: Container(
          width: screenW * 0.3,
          height: screenH * 0.3,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 196, 146, 39),
            boxShadow: [BoxShadow(blurRadius: 50)],
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
      bottom: -55,
      right: -45,
      child: Opacity(
        opacity: 0.6,
        child: Container(
          width: screenW * 0.36,
          height: screenH * 0.2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // Adjusted alpha in hex for clarity (0x95 is hex for 149 decimal)
            // The original color(0xff955cbeb2) might have been a typo,
            // assuming alpha was intended. If 0xff was intended as alpha,
            // it means fully opaque, making Opacity useless.
            // Using 0x95 based on the opacity value. Change if needed.
            color: Color(0x955CBEB2), // Or Color(0xFF5CBEB2) if fully opaque
            boxShadow: [BoxShadow(blurRadius: 50)],
          ),
        ),
      ),
    );
  }
}
