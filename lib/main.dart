import 'package:flutter/material.dart';
import 'package:najati_test/background.dart';
import 'package:najati_test/clip.dart';
import 'package:najati_test/register.dart';

import 'education.dart';

void main() {
  runApp(const MyApp());
}

late double screenW;
late double screenH;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenW = MediaQuery.sizeOf(context).width;
    screenH = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDEE9FD),
        // Optional: Also set this color as the default background for all Material widgets
        canvasColor: const Color(0xFFDEE9FD),
      ),

      home: LearnTogetherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
