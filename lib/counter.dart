import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';
import 'bubble.dart';
import 'core/constants/color_manager.dart';
import 'core/constants/image_manager.dart';
import 'custom_widget.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 1;
  bool imageAndCelebrate = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.passthrough,
        // clipBehavior: Clip.antiAlias,
        //clipBehavior: Clip.none,
        children: [
          TopRightCircleChild(),

          LeftBottomCircle(),
          RightBottomCircle(),
          SpeechBubblePage(),

          // Confetti Celebration
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,

              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: 0,
              emissionFrequency: 0.1,
              numberOfParticles: 30,
              maxBlastForce: 100,
              //20
              minBlastForce: 10,
              //8
              gravity: 0.4,
              shouldLoop: true,
            ),
          ),

          Positioned(
            top: screenH * 0.35,
            left: screenH * 0.06,
            child: Center(
              child: Container(
                width: screenW * 0.7,
                height: screenH * 0.53,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.container1Color,
                  //  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  gradient: ColorManager.container1BorderGradient,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: screenW * 0.55,
                    height: screenH * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: ColorManager.container2BackgroundGradient,
                      // borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, style: BorderStyle.solid),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          //           await LocalNotificationService.showBasicNotification;
                          setState(() {
                            counter++;
                            if (counter == 3) {
                              imageAndCelebrate = true;
                              _confettiController.play();
                            }
                          });
                        },
                        child: Container(
                          width: screenW * 0.42,
                          height: screenH * 0.39,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.container3Color,
                            //   borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            gradient: ColorManager.container3BorderGradient,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2F2C36).withOpacity(0.5),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: Center(
                            child:
                                imageAndCelebrate
                                    ? Image.asset(
                                      width: screenW * 0.47,
                                      height: screenH * 0.22,
                                      ImageManager.smile,
                                      fit: BoxFit.cover,
                                    )
                                    : ShaderMask(
                                      shaderCallback:
                                          (bounds) => const LinearGradient(
                                            colors: [
                                              Color(0xFF284273),
                                              Color(0xFF5280D4),
                                            ],
                                          ).createShader(bounds),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          counter.toString(),
                                          style: const TextStyle(
                                            fontSize: 52,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                              255,
                                              56,
                                              84,
                                              138,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
