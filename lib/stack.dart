import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';

import 'AfterSelectCharachter.dart';
import 'core/constants/image_manager.dart';

class StackList extends StatelessWidget {
  const StackList({super.key});

  @override
  Widget build(BuildContext context) {
    // List of colors and images for each item
    final List<Color> colors = [Colors.orange, Colors.yellow, Colors.blue];
    final List<String> images = [
      ImageManager.secondchild,
      ImageManager.firstchild,
      ImageManager.thirdchild,
    ];

    return Container(
      height: screenH * 0.26,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Stack(
              //      alignment: Alignment.topCenter,
              children: [
                // Bottom container
                Positioned(
                  bottom: 24,
                  child: Container(
                    width: screenW * 0.33,
                    height: screenH * 0.16,
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                // Top image
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AfterSelectCharachter(images[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: screenW * 0.44,
                      height: screenH * 0.27,
                      child: Image.asset(images[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
