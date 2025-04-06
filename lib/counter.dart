import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';
import 'core/constants/color_manager.dart';
import 'custom_widget.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 1;

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
            top: screenH * 0.12,
            bottom: 20,
            left: 5,

            child: Container(
              width: screenW * 0.4,
              height: screenH * 0.25,
              decoration: BoxDecoration(
                color: ColorManager.container1Color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, style: BorderStyle.solid),
                gradient: ColorManager.container1BorderGradient,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12),
                ],
              ),
              child: Center(
                child: Container(
                  width: screenW * 0.33,
                  height: screenH * 0.22,
                  decoration: BoxDecoration(
                    gradient: ColorManager.container2BackgroundGradient,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          counter++;
                        });
                      },
                      child: Container(
                        width: screenW * 0.3,
                        height: screenH * 0.2,
                        decoration: BoxDecoration(
                          color: ColorManager.container3Color,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, style: BorderStyle.solid),
                          gradient: ColorManager.container3BorderGradient,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF2F2C36).withOpacity(0.5),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Center(
                          child: ShaderMask(
                            shaderCallback:
                                (bounds) => LinearGradient(
                                  colors: [Color(0xFF284273), Color(0xFF5280D4)],
                                ).createShader(bounds),
                            child: Text(
                              counter.toString(),
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF284273),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
