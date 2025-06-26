import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/main.dart';
import 'package:najati_test/models/child/get_children_response.dart';
import 'package:najati_test/select_story.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:shimmer/shimmer.dart';

import 'AfterSelectCharachter.dart';
import 'clip.dart';
import 'core/constants/image_manager.dart';
import 'core/constants/url_manager.dart';
import 'models/charachter_model.dart';
import 'services/api/charachter.dart';

class StackList extends StatelessWidget {
  StackList({
    required this.args,
    required this.name,
    required this.childId,
    this.fatherName,
    required this.charachters,
    GetChildrenResponse? childrenResponse,
  });
  bool name;
  String? fatherName;
  String? args;
  int childId;
  GetCharacters? charachters;
  @override
  Widget build(BuildContext context) {
    // List of colors and images for each item

    return Container(
      height: screenH * 0.26,

      child: ScrollSnapList(
        itemSize: screenW * 0.45, // Should match your item
        dynamicItemSize: true,
        onItemFocus: (index) {
          // Optional: handle focused index change
        },
        scrollDirection: Axis.horizontal,
        itemCount: charachters!.data.length,
        itemBuilder: (context, index) {
          return Stack(
            //      alignment: Alignment.topCenter,
            children: [
              // Bottom container
              Positioned(
                bottom: 26,
                left: name ? 28 : 0,
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
                  onTap: () async {
                    try {
                      CharacterServiceImp create = CharacterServiceImp();
                      bool created = await create.createCharachter(
                        num: charachters!.data[index].id,
                        childId: childId,
                      );
                      if (created) {
                        // ✅ Show success SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('تم إنشاء الشخصية بنجاح'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        // ❌ Unexpected false (optional case)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'حدث خطأ غير متوقع أثناء إنشاء الشخصية',
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                    } catch (e) {
                      // ❗ Show known error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('حدث خطأ غير معروف'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    if (args == "getChild") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PrayerContainer(childId: childId),
                        ),
                      );
                    } else {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //   builder:
                      //       (context) => SelectStory(
                      //         image: charachters!.data[index].image,
                      //         name: charachters!.data[index].name,
                      //       ),
                      // ),
                      // );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: screenW * 0.44,
                      height: screenH * 0.27,
                      //   child: Image.asset(charachters!.data[index].image),
                      child: Image.network(
                        '${UrlManager.baseUrl}${charachters!.data[index].image}',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return Shimmer.fromColors(
                            baseColor:
                                const Color.fromARGB(255, 196, 250, 234)!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: screenW * 0.44,
                              height: screenH * 0.27,
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
