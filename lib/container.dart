import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/image_manager.dart';
import 'package:najati_test/main.dart';

// Helper Widget for Icon + Text
class PrayerColumn extends StatelessWidget {
  final String imagePath;
  final String text;

  String? prayerValid;
  String name;

  PrayerColumn({
    super.key,
    required this.imagePath,
    required this.text,

    required this.prayerValid,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          Image.asset(
            imagePath,
            width: 16,
            height: 16,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return const SizedBox(height: 16);
            },
          ),
        ],
      ),
    );
  }
}

class CutCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 12.0; // Border radius for top-right and bottom-right

    Path path =
        Path()
          ..moveTo(0, 0) // Start at top-left
          ..lineTo(size.width - radius, 0) // Top line to before top-right curve
          ..quadraticBezierTo(
            size.width,
            0,
            size.width,
            radius,
          ) // Top-right curve
          ..lineTo(
            size.width,
            size.height - radius,
          ) // Right vertical line before bottom-right curve
          ..quadraticBezierTo(
            size.width,
            size.height,
            size.width - radius,
            size.height,
          ) // Bottom-right curve
          ..lineTo(0, size.height) // Bottom line
          ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
