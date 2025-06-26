import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/url_manager.dart';

import '../../../config/header_config.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/widgets/textfield_common.dart';
import '../../../custom_widget.dart';
import '../../../dio_interceptor.dart';
import '../../../handling_model.dart';
import '../../../main.dart';
import '../model/get_sunnan.dart';

// inactiveTrackColor
// inactiveThumbColor

//   activeColor: Colors.green, // Thumb color when ON
//   activeTrackColor: Colors.greenAccent, // Track color when ON
//size containewidth
//fromabove
//when trrue the swiotch is and send request
///noti wajha
//scrolling

class SunnahPrayers extends StatefulWidget {
  SunnahPrayers(this.childId, this.nameChild, this.imageChild);
  String nameChild;
  String? imageChild;
  int childId;
  @override
  State<SunnahPrayers> createState() => _SunnahPrayersState();
}

Color textColorM = Color(0xFF1D2E4D);
int FontSize = 12;
bool isLoading = true;
// Switch(
//   activeColor:
//       Colors
//           .white, // Thumb color when ON
//   activeTrackColor:
//       const Color.fromARGB(
//         255,
//         163,
//         249,
//         252,
//       ),
//   value:
//       sunnahList[index].isActive == 1
//           ? true
//           : false,

//   onChanged: (value) {
//     setState(() {
//       isSwitched = value;
//     });
//   },
// ),

class TopRightCirclex extends StatelessWidget {
  TopRightCirclex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // خلي العرض والارتفاع متساويين عشان الدائرة تكون دائرية فعلاً
    final double size = screenW * 0.6;

    return Positioned(
      top: 20,
      right: -65,
      child: Opacity(
        opacity: 0.8,
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Color(0xffD6A2FF), blurRadius: 70),
              ],
              shape: BoxShape.circle,
              color: Color(0xff9556C6).withOpacity(0.07),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenW * 0.06),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "السنن",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF32C9C4),
                      ),
                      height: screenH * 0.13,
                      width: screenW * 0.2,
                      child: Icon(Icons.abc_sharp),

                      // fit: BoxFit.contain,
                      // child: Image.network(
                      //   "${UrlManager.baseUrl}${child.character.image}",
                      //   color:
                      //       profileResponse!
                      //                   .data
                      //                   .paid ==
                      //               true
                      //           ? null
                      //           : ColorManager
                      //               .blackOverlay,
                      //   width: 40,
                      //   height: 40,
                      //   fit: BoxFit.cover,
                      //   errorBuilder: (
                      //     context,
                      //     error,
                      //     stackTrace,
                      //   ) {
                      //     return const Icon(
                      //       Icons.broken_image,
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SunnahPrayersState extends State<SunnahPrayers> {
  bool isSwitched = false;
  bool showAllSunnahRawatebPrayers = false;
  bool sunnahListField = true;

  List<SunnahPrayer> rawatibSunnahList = [];
  List<SunnahPrayer> sunnahList = [];
  // أعلى StatefulWidget
  bool isLoading = false;
  String? errorMessage;
  bool isRawatebMasterSwitchOn = false;

  @override
  void initState() {
    super.initState();
    fetchSunnan();
  }

  void updateIsSwitched() {
    isSwitched = rawatibSunnahList.every((item) => item.isActive == 1);
  }

  final dio = DioClient.dio;

  Future<void> fetchSunnan() async {
    if (!mounted) return;
    setState(() => isLoading = true);

    try {
      final response = await dio.get(
        '${UrlManager.baseUrl}/api/child/${widget.childId}/prayers/sunnah',
        options: HeaderConfig.getHeader(useToken: true),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final sunnahResponse = SunnahResponse.fromJson(response.data);

        if (!mounted) return;
        setState(() {
          sunnahList = sunnahResponse.data.sunnah;
          rawatibSunnahList = sunnahResponse.data.rawatibSunnah;
          updateIsSwitched();
          isLoading = false;
        });
      } else {
        throw Exception("فشل تحميل البيانات");
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      _showSnackBar(
        "خطأ في الاتصال: ${e.message ?? 'غير معروف'}",
        isError: true,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      _showSnackBar("حدث خطأ: ${e.toString()}", isError: true);
    }
  }

  Future<bool> updateSunnahStatus({
    required int sunnahId,
    required bool turnOn,
  }) async {
    try {
      final response = await dio.post(
        '${UrlManager.baseUrl}/api/child/${widget.childId}/prayers/sunnah/$sunnahId/${turnOn ? 1 : 0}',
        options: HeaderConfig.getHeader(useToken: true),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : null,
        ),
      );
    });
  }

  // Future<void> _toggleAllRawatibSwitch(bool value) async {
  //   bool allSucceeded = true;

  //   _showSnackBar('سيتم تغيير الحالة', isError: false);

  //   for (var item in rawatibSunnahList) {
  //     final success = await updateSunnahStatus(
  //       sunnahId: item.id,
  //       turnOn: value,
  //     );
  //     if (success) {
  //       item.isActive = value ? 1 : 0; // ✅ تعديل مباشر في الكائن
  //     } else {
  //       allSucceeded = false;
  //       break;
  //     }
  //   }

  //   if (allSucceeded) {
  //     setState(() {
  //       isSwitched = value;
  //     });
  //   } else {
  //     _showSnackBar('فشل التحديث الجماعي', isError: true);
  //   }
  // }

  // Future<void> _toggleSingleSunnahSwitch(int sunnahId, bool value) async {
  //   _showSnackBar('سيتم تغيير الحالة', isError: false);

  //   final success = await updateSunnahStatus(sunnahId: sunnahId, turnOn: value);
  //   if (success) {
  //     setState(() {
  //       final index = rawatibSunnahList.indexWhere((s) => s.id == sunnahId);
  //       if (index != -1) {
  //         rawatibSunnahList[index].isActive = value ? 1 : 0;
  //       } else {
  //         final i = sunnahList.indexWhere((s) => s.id == sunnahId);
  //         if (i != -1) {
  //           sunnahList[i].isActive = value ? 1 : 0;
  //         }
  //       }
  //     });
  //   } else {
  //     _showSnackBar('فشل التحديث، حاول مرة أخرى', isError: true);
  //   }
  // }
  Future<void> _toggleAllRawatibSwitch(bool value) async {
    _showSnackBar('سيتم تغيير الحالة', isError: false);

    // Save current state in case we need to revert
    final previousStates =
        rawatibSunnahList.map((item) => item.isActive).toList();

    setState(() {
      for (var item in rawatibSunnahList) {
        item.isActive = value ? 1 : 0;
      }
      isSwitched = value;
    });

    bool allSucceeded = true;

    for (var item in rawatibSunnahList) {
      final success = await updateSunnahStatus(
        sunnahId: item.id,
        turnOn: value,
      );
      if (!success) {
        allSucceeded = false;
        break;
      }
    }

    if (!allSucceeded) {
      // Revert all to previous state
      setState(() {
        for (int i = 0; i < rawatibSunnahList.length; i++) {
          rawatibSunnahList[i].isActive = previousStates[i];
        }
        updateIsSwitched();
      });
      _showSnackBar('فشل التحديث الجماعي', isError: true);
    }
  }

  Future<void> _toggleSingleSunnahSwitch(
    SunnahPrayer sunnah,
    bool value,
  ) async {
    final previousValue = sunnah.isActive;
    setState(() {
      sunnah.isActive = value ? 1 : 0;
      updateIsSwitched(); // update master switch status
    });

    final success = await updateSunnahStatus(
      sunnahId: sunnah.id,
      turnOn: value,
    );
    if (!success) {
      setState(() {
        sunnah.isActive = previousValue;
        updateIsSwitched();
      });
      _showSnackBar('فشل التحديث، حاول مرة أخرى', isError: true);
    }
  }

  Widget _buildSunnahSwitchTileRawatebTrue(
    SunnahPrayer sunnah, {
    double scale = 1.0,
  }) {
    return Container(
      // decoration: DecorationField.decorationContainer,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(right: screenW * 0.09),
          child: Text(sunnah.name, textAlign: TextAlign.right),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(right: screenW * 0.09),
          child: const Text(
            "يمكنك ادراج بعض السنن الخفيفة بالبداية",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ),
        leading: Transform.scale(
          scale: 0.8,
          child: Switch(
            activeColor: Colors.white, // Thumb color when ON
            activeTrackColor: const Color(0xFF32C9C4),
            value: sunnah.isActive == 1,
            onChanged: (val) => _toggleAllRawatibSwitch(val),
          ),
        ),
        trailing: SizedBox(),
        contentPadding: EdgeInsets.all(7),
      ),
    );
  }

  Widget _buildSunnahSwitchTile(SunnahPrayer sunnah, {double scale = 1.0}) {
    return Container(
      decoration: DecorationField.decorationContainer,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(right: screenW * 0.03),
          child: Text(sunnah.name, textAlign: TextAlign.right),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(right: screenW * 0.03),
          child: const Text(
            "يمكنك ادراج بعض السنن الخفيفة بالبداية",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ),
        leading: Transform.scale(
          scale: 0.8,
          child: Switch(
            activeColor: Colors.white, // Thumb color when ON
            activeTrackColor: const Color(0xFF32C9C4),
            value: sunnah.isActive == 1,
            onChanged: (val) => _toggleSingleSunnahSwitch(sunnah, val),
          ),
        ),
        trailing: SizedBox(),
      ),
    );
  }

  Widget _buildSunnahSwitchTileforSingleRawateb(
    SunnahPrayer sunnah, {
    double scale = 1.0,
  }) {
    return Container(
      // decoration: DecorationField.decorationContainer,
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(right: screenW * 0.03),
          child: Text(sunnah.name, textAlign: TextAlign.right),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(right: screenW * 0.03),
          child: const Text(
            "يمكنك ادراج بعض السنن الخفيفة بالبداية",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 9, color: Colors.grey),
          ),
        ),
        leading: Transform.scale(
          scale: 0.8,
          child: Switch(
            activeColor: Colors.white, // Thumb color when ON
            activeTrackColor: const Color(0xFF32C9C4),
            value: sunnah.isActive == 1,
            onChanged: (val) => _toggleSingleSunnahSwitch(sunnah, val),
          ),
        ),
        trailing: SizedBox(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
              ? Center(child: Text("خطأ: $errorMessage"))
              : rawatibSunnahList.isEmpty
              ? Center(child: Text("لا توجد بيانات متاحة"))
              : Stack(
                children: [
                  TopRightCirclex(),

                  LeftBottomCircle(),
                  RightBottomCircle(),
                  Positioned(
                    top: screenH * 0.15,
                    //right: 5,
                    left: screenW * 0.03,
                    child: Icon(Icons.chevron_left),
                  ),
                  Positioned(
                    right: 5,
                    top: screenH * 0.32,
                    bottom: 20,
                    left: 5,
                    child:
                        showAllSunnahRawatebPrayers == false
                            ? Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                left: 8,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: screenW * 0.94,
                                    height: screenH * 0.1,
                                    decoration:
                                        DecorationField.decorationContainer,
                                    child: ListTile(
                                      title: Text(
                                        textAlign: TextAlign.right,
                                        "السنن الرواتب",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: textColorM,
                                        ),
                                      ),
                                      subtitle: Text(
                                        textAlign: TextAlign.right,
                                        "يمكنك ادراج بعض السنن الخفيفة بالبداية",
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.expand_more,
                                          size: 28,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showAllSunnahRawatebPrayers =
                                                !showAllSunnahRawatebPrayers;
                                          });
                                        },
                                      ),
                                      leading: Transform.scale(
                                        scale: 0.8,
                                        // activeColor:
                                        //       Colors.green, // Thumb color when ON
                                        //     activeTrackColor:
                                        // Colors.greenAccent, // Track color when ON
                                        //
                                        child: Switch(
                                          activeColor:
                                              Colors
                                                  .white, // Thumb color when ON
                                          activeTrackColor: const Color(
                                            0xFF32C9C4,
                                          ),
                                          value: isSwitched,
                                          onChanged:
                                              (value) =>
                                                  _toggleAllRawatibSwitch(
                                                    value,
                                                  ),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(7),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: _buildSunnahSwitchTile(
                                            sunnahList[index],
                                          ),
                                        );
                                      },
                                      itemCount: sunnahList.length,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: Container(
                                      width: screenW * 0.94,
                                      decoration:
                                          DecorationField.decorationContainer,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.all(7),

                                            title: Text(
                                              textAlign: TextAlign.right,
                                              "السنن الرواتب",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: textColorM,
                                              ),
                                            ),
                                            subtitle: Text(
                                              textAlign: TextAlign.right,
                                              "يمكنك ادراج بعض السنن الخفيفة بالبداية",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  showAllSunnahRawatebPrayers =
                                                      !showAllSunnahRawatebPrayers;
                                                });
                                              },
                                            ),
                                            leading: Transform.scale(
                                              scale: 0.8,
                                              child: Switch(
                                                activeColor:
                                                    Colors
                                                        .white, // Thumb color when ON
                                                activeTrackColor: const Color(
                                                  0xFF32C9C4,
                                                ),
                                                value: isSwitched,
                                                onChanged:
                                                    (value) =>
                                                        _toggleAllRawatibSwitch(
                                                          value,
                                                        ),
                                              ),
                                            ),
                                          ),
                                          Divider(color: Colors.white),
                                          Container(
                                            // height:
                                            //     rawatibSunnahList.length *
                                            //     (0.1 * screenH),
                                            child: ListView.builder(
                                              shrinkWrap:
                                                  true, // VERY IMPORTANT
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return _buildSunnahSwitchTileforSingleRawateb(
                                                  rawatibSunnahList[index],
                                                  scale: 0.8,
                                                );
                                              },
                                              itemCount:
                                                  rawatibSunnahList.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true, // VERY IMPORTANT
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: _buildSunnahSwitchTile(
                                          sunnahList[index],
                                          scale: 0.8,
                                        ),
                                      );
                                    },
                                    itemCount: sunnahList.length,
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
