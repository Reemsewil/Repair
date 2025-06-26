import 'dart:developer';

import 'package:just_audio/just_audio.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/image_manager.dart';
import 'package:najati_test/settings.dart';
import 'core/constants/color_manager.dart';
import 'core/constants/url_manager.dart';
import 'custom_widget.dart';
import 'main.dart';
import 'models/educational_section/get_story_response.dart';
import 'services/api/educational_section.dart';
import 'stack.dart';

class SelectStory extends StatefulWidget {
  SelectStory({super.key, required this.name, required this.result});
  String name;
  List<CharacterItem> result;

  @override
  State<SelectStory> createState() => _SelectStoryState();
}

class _SelectStoryState extends State<SelectStory> {
  String audioPath = "";

  String audioUrl = UrlManager.baseUrl;

  final AudioPlayer _audioPlayer = AudioPlayer();

  //ios
  // <key>NSAppTransportSecurity</key>
  // <dict>
  //   <key>NSAllowsArbitraryLoads</key>
  //   <true/>
  // </dict>

  Future<void> playAudio(String url) async {
    try {
      log("Attempting to play: $url");

      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      await _audioPlayer.play();

      log("Audio should now be playing.");
    } catch (e) {
      log("Audio error: $e");
    }
  }

  bool isLoading = true;
  final ValueNotifier<int> index = ValueNotifier<int>(0);

  @override
  void dispose() {
    index.dispose();

    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _audioPlayer.playerStateStream.listen((state) {
      log("Player state: ${state.processingState} | Playing: ${state.playing}");
    });
  }

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
            top: screenH * 0.12,
            left: 20,
            child: Material(
              color: Colors.transparent,

              // child: GestureDetector(
              //   onTap: () async {
              //     await _audioPlayer.stop(); // 👈 stop the audio

              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Settings()),
              //     );
              //   },
              //   child: Icon(
              //     Icons.settings,
              //     color: ColorManager.deepPurple,
              //     size: 40,
              //   ),
              // ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenH * 0.12),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenW * 0.07),
                        child: Material(
                          color: Colors.transparent,

                          child: GestureDetector(
                            onTap: () async {
                              await _audioPlayer.stop(); // 👈 stop the audio

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Settings(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: ColorManager.deepPurple,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Container(
                            width: screenW * 0.54,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  " ${widget.name} ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.deepPurple,
                                  ),
                                ),
                                Text(
                                  "لنتعلم معاً ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // SizedBox(height: screenH * 0.05),
                ValueListenableBuilder<int>(
                  valueListenable: index,
                  builder: (context, index, _) {
                    // Row of learning cards
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1.0, 0.0), // slide in from right
                            end: Offset(0.0, 0.0),
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },

                      child: Container(
                        key: ValueKey<int>(index), // 👈 IMPORTANT: add this!
                        margin: EdgeInsets.symmetric(horizontal: 13),
                        padding: EdgeInsets.all(16),

                        width: screenW * 0.85,
                        height: screenH * 0.53,
                        decoration: BoxDecoration(
                          color: Color(0xFFBDE9E5),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Image
                              SizedBox(height: screenH * 0.032),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //  const SizedBox(width: 50),
                                  Container(
                                    width: screenW * 0.6,
                                    height: screenH * 0.29,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        '${UrlManager.baseUrl}${widget.result[index].image}',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (
                                          context,
                                          child,
                                          progress,
                                        ) {
                                          if (progress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                              // Text + Sound Icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(widget.result[index].description),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    onTap: () {
                                      log("===");
                                      audioPath =
                                          "$audioUrl${widget.result[index].sound}";

                                      playAudio(audioPath);
                                    },
                                    child: Container(
                                      width: screenW * 0.09,
                                      height: screenW * 0.09,

                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                          255,
                                          243,
                                          238,
                                          238,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image(
                                        image: AssetImage(ImageManager.voice),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //      const SizedBox(height: 32),

                // Navigation Arrows
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: circularArrowButton(
                          icon: Icons.arrow_back,
                          onTap: () {
                            // handle back
                            if (index.value > 0) {
                              print(
                                'Forward tapped. Current index.value: ${index.value}',
                              );

                              log(index.value.toString());

                              if (index.value > 0) {
                                index.value--;
                              }

                              log(index.value.toString());
                            }
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: circularArrowButton(
                          icon: Icons.arrow_forward,
                          onTap: () {
                            print('Arrow forward clicked');

                            // handle forward
                            //    nextCard();
                            log(
                              'Forward tapped. Current index.value: ${index.value}',
                            );
                            log(
                              'Forward tapped. Current index.value: ${widget.result.length}',
                            );
                            log("Result list length: ${widget.result.length}");

                            if (index.value < widget.result.length - 1) {
                              log(
                                'Forward tapped. Current index.value: ${index.value}',
                              );

                              index.value++;
                              log(
                                'Forward tapped. Current index.value: ${index.value}',
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  final Color backgroundColor;
  const LearningCard({
    Key? key,
    required this.imagePath,
    required this.label,
    this.backgroundColor = const Color(0xFF95D1C8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW * 0.3,
      height: screenH * 0.16,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
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
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

Widget circularArrowButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF8466D3), Color(0xFF92B6F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white),
    ),
  );
}
