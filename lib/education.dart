import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/models/educational_section/get_all_stories_response.dart';
import 'package:najati_test/services/api/educational_section.dart';
import 'package:najati_test/settings.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shimmer/shimmer.dart';

import 'core/constants/color_manager.dart';
import 'core/constants/image_manager.dart';
import 'core/constants/url_manager.dart';
import 'custom_widget.dart';
import 'main.dart';
import 'models/charachter_model.dart';
import 'models/educational_section/get_story_response.dart';
import 'select_story.dart';
import 'services/api/charachter.dart';
import 'stack.dart';

class LearnTogetherScreen extends StatefulWidget {
  LearnTogetherScreen({super.key});

  @override
  State<LearnTogetherScreen> createState() => _LearnTogetherScreenState();
}

class _LearnTogetherScreenState extends State<LearnTogetherScreen> {
  String section = "";
  List<EducationalSection> _sections = [];
  bool _isLoading = true;
  bool isLoading = true;

  String? _errorMessage;
  final EducationalSectionService _sectionService =
      EducationalSectionServiceImp();

  //   bool openCharachter = false;
  //   late GetAllStoriesResponse res;
  //   EducationalSectionServiceImp model = EducationalSectionServiceImp(dio: Dio());
  //   @override
  //   void initState() {
  //     super.initState();
  //     _loadData();
  //   }

  //   void _loadData() async {
  //     try {
  //       res = await model.getAllStories(); // Call your API
  //       // Use the response as needed
  //     } catch (e) {
  //       print("API call failed: $e");
  //     }
  //   }

  //   bool isStoryHovered = false;
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       backgroundColor: const Color(0xFFEAF1FB),
  //       body: Stack(
  //         children: [
  //           TopRightCircle(),
  //           LeftBottomCircle(),
  //           RightBottomCircle(),

  //           // Top-left gear icon
  //           Positioned(
  //             top: screenH * 0.12,
  //             left: 20,
  //             child: Icon(
  //               Icons.settings,
  //               color: ColorManager.deepPurple,
  //               size: 40,
  //             ),
  //           ),

  //           // Main content
  //           Column(
  //             // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.symmetric(vertical: screenH * 0.1),
  //                 child: Container(
  //                   width: screenW * 0.46,
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 20,
  //                     vertical: 5,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white.withOpacity(0.3),
  //                     borderRadius: BorderRadius.circular(40),
  //                   ),
  //                   child: Center(
  //                     child: const Text(
  //                       "لنتعلم معاً",
  //                       style: TextStyle(
  //                         fontSize: 22,
  //                         fontWeight: FontWeight.bold,
  //                         color: ColorManager.deepPurple,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),

  //               // SizedBox(height: screenH * 0.05),

  //               // Row of learning cards
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   MouseRegion(
  //                     onEnter: (_) => setState(() => isStoryHovered = true),
  //                     onExit: (_) => setState(() => isStoryHovered = false),
  //                     child: InkWell(
  //                       onTap: () {
  //                         setState(() {
  //                           openCharachter = true;
  //                         });
  //                       },
  //                       child: LearningCard(
  //                         imagePath: ImageManager.prayer,
  //                         label: 'الصلاة',
  //                         backgroundColor:
  //                             isStoryHovered
  //                                 ? Color(0xFF95D1C8)
  //                                 : const Color(0xFF95D1C8),
  //                       ),
  //                     ),
  //                   ),
  //                   LearningCard(
  //                     imagePath: ImageManager.prayer,
  //                     label: 'الوضوء',
  //                     backgroundColor:
  //                         isStoryHovered
  //                             ? const Color.fromARGB(255, 160, 194, 189)
  //                             : const Color(0xFF95D1C8),
  //                   ),
  //                 ],
  //               ),
  //               openCharachter
  //                   ? Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       openCharachter
  //                           ? Padding(
  //                             padding: EdgeInsets.symmetric(
  //                               vertical: screenH * 0.03,
  //                             ),
  //                             child: Text(".. سنتعلم الوضوء مع "),
  //                           )
  //                           : Text(""),

  //                       StackList(name: false),
  //                     ],
  //                   )
  //                   : SizedBox(),
  //             ],
  //           ),

  //           // "m" speech-bubble avatar
  //         ],
  //       ),
  //     );
  //   }
  // }

  bool openCharachter = false;
  GetAllStoriesResponse res = GetAllStoriesResponse(status: '', data: []);
  EducationalSectionServiceImp model = EducationalSectionServiceImp();
  bool isStoryHovered = false;

  GetCharacters? charachterResponse;
  int num = 0;

  EducationalSectionDetailResponse? result;

  final EducationalSectionServiceImp storyService =
      EducationalSectionServiceImp();
  Future<void> getStoryDetails(int storyId) async {
    try {
      result = await storyService.getStory(storyId: storyId);
      log("Story title: ${result!.data.name}");
    } catch (e) {
      log("Error fetching story: $e");
    } finally {
      setState(() {
        isLoading = false;
        openCharachter = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    // fetchCharachter();
  }

  void _loadData() async {
    try {
      final response = await _sectionService.getAllStories();
      log("++++++++++++++++++++++++++++++++++++++");
      setState(() {
        _sections = response.data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEE9FD),
      body: Stack(
        children: [
          TopRightCircle(),
          LeftBottomCircle(),
          RightBottomCircle(),

          // Top-left gear icon
          Positioned(
            top: screenH * 0.12,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
              child: Icon(
                Icons.settings,
                color: ColorManager.deepPurple,
                size: 40,
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenH * 0.1),
                child: Container(
                  width: screenW * 0.46,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text(
                      "لنتعلم معاً",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                    height: screenH * 0.22,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenW * 0.076,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _sections.length,
                        //  padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemBuilder: (context, index) {
                          final item = _sections[index];
                          return InkWell(
                            onTap: () {
                              log(index.toString());
                              log("hi ima here ");
                              getStoryDetails(_sections[index].id);
                              setState(() {
                                section = _sections[index].name;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenW * 0.024,
                              ),
                              child: LearningCard(
                                imagePath: '${UrlManager.baseUrl}${item.image}',
                                label: item.name,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  126,
                                  192,
                                  182,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

              openCharachter
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenW * 0.024,
                          top: screenH * 0.06,
                        ),
                        child: Container(
                          child: Text(
                            ".. سنتعلم $section مع ",
                            style: TextStyle(color: Color(0xFF1D2E4D)),
                          ),
                        ),
                      ),
                      Container(
                        height: screenH * 0.26,
                        child: ScrollSnapList(
                          itemSize:
                              screenW * 0.45, // Should match your item width
                          dynamicItemSize: true,
                          onItemFocus: (index) {
                            // Optional: handle focused index change
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: result!.data.characters.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              //      alignment: Alignment.topCenter,
                              children: [
                                // Bottom container
                                Positioned(
                                  bottom: 26,
                                  left: 28,
                                  child: Container(
                                    width: screenW * 0.35,
                                    height: screenH * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
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
                                  padding: EdgeInsets.only(top: screenH * 0.02),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => SelectStory(
                                                result:
                                                    result!
                                                        .data
                                                        .characters[index]
                                                        .items,
                                                name: section,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        width: screenW * 0.44,
                                        height: screenH * 0.27,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.network(
                                            '${UrlManager.baseUrl}${result!.data.characters[index].character.image}',
                                            fit: BoxFit.cover,
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress == null)
                                                return child;

                                              return Shimmer.fromColors(
                                                baseColor:
                                                    const Color.fromARGB(
                                                      255,
                                                      196,
                                                      250,
                                                      234,
                                                    )!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: screenW * 0.44,
                                                  height: screenH * 0.27,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                        // child: Image.asset(
                                        //   ImageManager.firstchild,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                  : SizedBox(),
            ],
          ),
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
    this.backgroundColor = const Color.fromARGB(255, 55, 173, 156),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenW * 0.37,
      height: screenH * 0.1,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            //  color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child; // show image when loaded

                  return Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 196, 250, 234)!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 200, // Or any height you expect for the image
                      color: Colors.white,
                    ),
                  );
                },
                errorBuilder:
                    (context, error, stackTrace) => Icon(Icons.broken_image),
              ),
            ),
          ),
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
