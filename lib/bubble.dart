import 'package:flutter/material.dart';

class SpeechBubblePage extends StatelessWidget {
  const SpeechBubblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FB), // base background
      body: Stack(
        children: [
          // Gradient circle in background
          Positioned(
            right: -50,
            top: 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFB188F7), Color(0x00FFFFFF)],
                  radius: 0.8,
                ),
              ),
            ),
          ),

          // Main content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Speech bubble
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SpeechBubble(
                        text:
                            'الاعتذار هو خير وسيلة لتصحيح الخطأ . \nو لذلك لنقم بالاستغفار بصدق',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Character image
                  Image.asset(
                    'assets/images/child_character.png',
                    width: 140,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    final path = Path();
    path.moveTo(size.width - 20, size.height); // start tail from bottom-right
    path.lineTo(size.width - 10, size.height + 10);
    path.lineTo(size.width - 40, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SpeechBubble extends StatelessWidget {
  final String text;

  const SpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubbleTailPainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 20), // spacing from tail
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            height: 1.4,
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
