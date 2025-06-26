// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:najati_test/core/constants/url_manager.dart';

// import '../../../config/header_config.dart';
// import '../../../core/widgets/textfield_common.dart';
// import '../../../custom_widget.dart';
// import '../../../handling_model.dart';
// import '../../../main.dart';
// import '../model/get_sunnan.dart';

// // inactiveTrackColor
// // inactiveThumbColor

// //   activeColor: Colors.green, // Thumb color when ON
// //   activeTrackColor: Colors.greenAccent, // Track color when ON
// //size containewidth
// //fromabove
// //when trrue the swiotch is and send request
// ///noti wajha
// //scrolling

// class SunnahPrayers extends StatefulWidget {
//   SunnahPrayers(this.childId, this.nameChild, this.imageChild);
//   String nameChild;
//   String? imageChild;
//   int childId;
//   @override
//   State<SunnahPrayers> createState() => _SunnahPrayersState();
// }

// Color textColorM = Color(0xFF1D2E4D);
// int FontSize = 12;
// bool isLoading = true;
//     // Switch(
//                                         //   activeColor:
//                                         //       Colors
//                                         //           .white, // Thumb color when ON
//                                         //   activeTrackColor:
//                                         //       const Color.fromARGB(
//                                         //         255,
//                                         //         163,
//                                         //         249,
//                                         //         252,
//                                         //       ),
//                                         //   value:
//                                         //       sunnahList[index].isActive == 1
//                                         //           ? true
//                                         //           : false,

//                                         //   onChanged: (value) {
//                                         //     setState(() {
//                                         //       isSwitched = value;
//                                         //     });
//                                         //   },
//                                         // ),
// class _SunnahPrayersState extends State<SunnahPrayers> {
//   bool isSwitched = false;
//   bool showAllSunnahRawatebPrayers = false;
//   bool sunnahListField = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchSunnan();
//     updateIsSwitchedFromList();
//   }

//   void updateIsSwitchedFromList() {
//     isSwitched = rawatibSunnahList.every((item) => item.isActive == 1);
//   }

//   Future<bool> putTurnOn(int sunnahId, int childId) async {
//     {
//       Dio dio = Dio();
//       Response response = await dio.post(
//         '${UrlManager.baseUrl}/api/child/${widget.childId}/prayers/sunnah/$sunnahId/1',
//         options: HeaderConfig.getHeader(useToken: true),
//       );

//       if (response.statusCode == 200) {
//         return true;
//       } else
//         return false;
//     }
//   }

//   Future<bool> putTurnOff(int sunnahId, int childId) async {
//     {
//       Dio dio = Dio();
//       Response response = await dio.post(
//         '${UrlManager.baseUrl}/api/child/${widget.childId}/prayers/sunnah/$sunnahId/0',
//         options: HeaderConfig.getHeader(useToken: true),
//       );

//       if (response.statusCode == 200) {
//         return true;
//       } else
//         return false;
//     }
//   }

//   List<SunnahPrayer> rawatibSunnahList = [];
//   List<SunnahPrayer> sunnahList = [];
//   // أعلى StatefulWidget
//   bool isLoading = false;
//   String? errorMessage;
//   bool isRawatebMasterSwitchOn = false;

//   Future<bool> updateSunnahStatus({
//     required int sunnahId,
//     required int childId,
//     required bool turnOn,
//   }) async {
//     final dio = Dio();
//     int x = 0;
//     turnOn == true ? x = 1 : 0;
//     log("${UrlManager.baseUrl}/api/child/$childId/prayers/sunnah/$sunnahId/$x");
//     final response = await dio.post(
//       '${UrlManager.baseUrl}/api/child/$childId/prayers/sunnah/$sunnahId/$x',
//       options: HeaderConfig.getHeader(useToken: true),
//     );

//     return response.statusCode == 200;
//   }

//   Future<void> fetchSunnan() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       Dio dio = Dio();
//       Response response = await dio.get(
//         '${UrlManager.baseUrl}/api/child/${widget.childId}/prayers/sunnah',
//         options: HeaderConfig.getHeader(useToken: true),
//       );
//       log("${widget.childId}");
//       if (response.statusCode == 200) {
//         log("sonaaaaaaaaaaaaaaaaaaan");
//         log(response.statusCode.toString());
//         // log(response.data['data']['rawatib_sunnah']);
//         final sunnahResponse = SunnahResponse.fromJson(response.data);

//         setState(() {
//           sunnahList = sunnahResponse.data.sunnah;

//           rawatibSunnahList = sunnahResponse.data.rawatibSunnah;
//           log(sunnahList.length.toString());
//           log(rawatibSunnahList.length.toString());

//           isLoading = false;
//         });
//       } else {
//         throw Exception("فشل تحميل البيانات");
//       }
//     } on DioException catch (e) {
//       setState(() {
//         isLoading = false;
//       });

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("خطأ في الاتصال: ${e.message ?? 'غير معروف'}"),
//             backgroundColor: Colors.red,
//           ),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("حدث خطأ: ${e.toString()}"),
//             //   backgroundColor: Colors.red,
//           ),
//         );
//       });
//     }
//   }
//   //  Future<void> _onToggle(bool value) async {
//   //     setState(() => isLoading = true);

//   //     final success = await updateSunnahStatus(
//   //       sunnahId: widget.sunnahPrayer.id,
//   //       childId: widget.childId,
//   //       turnOn: value,
//   //     );

//   //     setState(() => isLoading = false);

//   //     if (success) {
//   //       setState(() => isSunnahActive = value);
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('فشل التحديث. حاول مرة أخرى.')),
//   //       );
//   //     }
//   //   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (errorMessage != null) {
//       return Center(child: Text("خطأ: $errorMessage"));
//     }
//     if (rawatibSunnahList.isEmpty) {
//       return const Center(child: Text("لا توجد بيانات متاحة"));
//     }
//     return Scaffold(
//       body: Stack(
//         children: [
//           TopRightCircle(),
//           LeftBottomCircle(),
//           RightBottomCircle(),
//           Positioned(
//             top: 60,
//             right: 5,
//             // left: 10,
//             child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.abc_sharp),
//                 SizedBox(width: screenW * 0.7),

//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Container(
//                         decoration: BoxDecoration(shape: BoxShape.circle),
//                         height: screenH * 0.13,
//                         width: screenW * 0.09,
//                         child: Icon(Icons.chevron_left),
//                         // fit: BoxFit.contain,
//                         // child: Image.network(
//                         //   "${UrlManager.baseUrl}${child.character.image}",
//                         //   color:
//                         //       profileResponse!
//                         //                   .data
//                         //                   .paid ==
//                         //               true
//                         //           ? null
//                         //           : ColorManager
//                         //               .blackOverlay,
//                         //   width: 40,
//                         //   height: 40,
//                         //   fit: BoxFit.cover,
//                         //   errorBuilder: (
//                         //     context,
//                         //     error,
//                         //     stackTrace,
//                         //   ) {
//                         //     return const Icon(
//                         //       Icons.broken_image,
//                         //     );
//                         //   },
//                         // ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("السنن", style: TextStyle(fontSize: 10)),
//                     ),
//                   ],
//                 ),

//                 //   Spacer(),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 5,
//             top: screenH * 0.32,
//             bottom: 20,
//             left: 5,
//             child:
//                 showAllSunnahRawatebPrayers == false
//                     ? Padding(
//                       padding: const EdgeInsets.only(right: 8.0, left: 8),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: screenW * 0.94,
//                             height: screenH * 0.1,
//                             decoration: DecorationField.decorationContainer,
//                             child: ListTile(
//                               title: Text(
//                                 textAlign: TextAlign.right,
//                                 "السنن الرواتب",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: textColorM,
//                                 ),
//                               ),
//                               subtitle: Text(
//                                 textAlign: TextAlign.right,
//                                 "يمكنك ادراج بعض السنن الخفيفة بالبداية",
//                                 style: TextStyle(
//                                   fontSize: 9,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               trailing: IconButton(
//                                 icon: Icon(
//                                   Icons.expand_more,
//                                   size: 28,
//                                   color: Colors.grey,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     showAllSunnahRawatebPrayers =
//                                         !showAllSunnahRawatebPrayers;
//                                   });
//                                 },
//                               ),
//                               leading: Transform.scale(
//                                 scale: 0.8,
//                                 // activeColor:
//                                 //       Colors.green, // Thumb color when ON
//                                 //     activeTrackColor:
//                                 // Colors.greenAccent, // Track color when ON
//                                 //
//                                 child: Switch(
//                                   value: rawatibSunnahList.every(
//                                     (item) => item.isActive == 1,
//                                   ),
//                                   onChanged: (value) async {
//                                     bool allSucceeded = true;

//                                     for (var item in rawatibSunnahList) {
//                                       final success = await updateSunnahStatus(
//                                         sunnahId: item.id,
//                                         childId: widget.childId,
//                                         turnOn: value,
//                                       );

//                                       if (!success) {
//                                         allSucceeded = false;
//                                         break;
//                                       }
//                                     }

//                                     if (allSucceeded) {
//                                       await fetchSunnan();
//                                       setState(() {});
//                                     } else {
//                                       ScaffoldMessenger.of(
//                                         context,
//                                       ).showSnackBar(
//                                         SnackBar(
//                                           content: Text('فشل التحديث الجماعي'),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ),
//                               contentPadding: EdgeInsets.all(7),
//                             ),
//                           ),
//                           Flexible(
//                             child: ListView.builder(
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 8.0),
//                                   child: Container(
//                                     width: screenW * 0.94,
//                                     height: screenH * 0.1,
//                                     decoration:
//                                         DecorationField.decorationContainer,
//                                     child: ListTile(
//                                       title: Padding(
//                                         padding: EdgeInsets.only(
//                                           right: screenW * 0.05,
//                                         ),
//                                         child: Text(
//                                           textAlign: TextAlign.right,
//                                           sunnahList[index].name,
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             color: textColorM,
//                                           ),
//                                         ),
//                                       ),
//                                       subtitle: Padding(
//                                         padding: EdgeInsets.only(
//                                           right: screenW * 0.05,
//                                         ),
//                                         child: Text(
//                                           textAlign: TextAlign.right,
//                                           "يمكنك ادراج بعض السنن الخفيفة بالبداية",
//                                           style: TextStyle(
//                                             fontSize: 9,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ),
//                                       leading: Transform.scale(
//                                         scale: 0.8,
//                                         // fit: BoxFit.contain,
//                                         child:

//                                          Switch(
//                                         value: sunnahList[index].isActive == 1,
//                                         onChanged: (value) async {
//                                           final sunnahId = sunnahList[index].id;
//                                           final success =
//                                               value
//                                                   ? await putTurnOn(
//                                                     sunnahId,
//                                                     widget.childId,
//                                                   )
//                                                   : await putTurnOff(
//                                                     sunnahId,
//                                                     widget.childId,
//                                                   );

//                                           if (success) {
//                                             // Re-fetch updated data from server
//                                             await fetchSunnan(); // This updates rawatibSunnahList and sunnahList
//                                             setState(() {}); // Refresh UI
//                                           } else {
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   'فشل التحديث، حاول مرة أخرى',
//                                                 ),
//                                               ),
//                                             );
//                                           }
//                                         },
//                                       ),
//                                       ),
//                                       trailing: SizedBox(),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               itemCount: sunnahList.length,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                     : Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8, bottom: 8),
//                             child: Container(
//                               width: screenW * 0.94,
//                               decoration: DecorationField.decorationContainer,
//                               child: Column(
//                                 children: [
//                                   ListTile(
//                                     contentPadding: EdgeInsets.all(7),

//                                     title: Text(
//                                       textAlign: TextAlign.right,
//                                       "السنن الرواتب",
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: textColorM,
//                                       ),
//                                     ),
//                                     subtitle: Text(
//                                       textAlign: TextAlign.right,
//                                       "يمكنك ادراج بعض السنن الخفيفة بالبداية",
//                                       style: TextStyle(
//                                         fontSize: 9,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     trailing: IconButton(
//                                       icon: const Icon(
//                                         Icons.keyboard_arrow_down,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           showAllSunnahRawatebPrayers =
//                                               !showAllSunnahRawatebPrayers;
//                                         });
//                                       },
//                                     ),
//                                     leading: Transform.scale(
//                                       scale: 0.8,
//                                       child: Switch(
//                                         value: rawatibSunnahList.every(
//                                           (item) => item.isActive == 1,
//                                         ),
//                                         onChanged: (value) async {
//                                           bool allSucceeded = true;

//                                           for (var item in rawatibSunnahList) {
//                                             final success =
//                                                 await updateSunnahStatus(
//                                                   sunnahId: item.id,
//                                                   childId: widget.childId,
//                                                   turnOn: value,
//                                                 );

//                                             if (!success) {
//                                               allSucceeded = false;
//                                               break;
//                                             }
//                                           }

//                                           if (allSucceeded) {
//                                             await fetchSunnan();
//                                             setState(() {});
//                                           } else {
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   'فشل التحديث الجماعي',
//                                                 ),
//                                               ),
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Divider(color: Colors.white),
//                                   Container(
//                                     // height:
//                                     //     rawatibSunnahList.length *
//                                     //     (0.1 * screenH),
//                                     child: ListView.builder(
//                                       shrinkWrap: true, // VERY IMPORTANT
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         return Container(
//                                           child: ListTile(
//                                             title: Padding(
//                                               padding: EdgeInsets.only(
//                                                 right: screenW * 0.09,
//                                               ),
//                                               child: Text(
//                                                 textAlign: TextAlign.right,
//                                                 rawatibSunnahList[index].name,
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   color: textColorM,
//                                                 ),
//                                               ),
//                                             ),
//                                             subtitle: Padding(
//                                               padding: EdgeInsets.only(
//                                                 right: screenW * 0.09,
//                                               ),
//                                               child: Text(
//                                                 textAlign: TextAlign.right,
//                                                 "يمكنك ادراج بعض السنن الخفيفة بالبداية",
//                                                 style: TextStyle(
//                                                   fontSize: 9,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                             ),
//                                             leading: Transform.scale(
//                                               scale: 0.8,
//                                               child: Switch(
//                                                 value:
//                                                     rawatibSunnahList[index]
//                                                         .isActive ==
//                                                     1,
//                                                 onChanged: (value) async {
//                                                   final sunnahId =
//                                                       rawatibSunnahList[index]
//                                                           .id;
//                                                   final success =
//                                                       value
//                                                           ? await putTurnOn(
//                                                             sunnahId,
//                                                             widget.childId,
//                                                           )
//                                                           : await putTurnOff(
//                                                             sunnahId,
//                                                             widget.childId,
//                                                           );

//                                                   if (success) {
//                                                     // Re-fetch updated data from server
//                                                     await fetchSunnan(); // This updates rawatibSunnahList and sunnahList
//                                                     setState(
//                                                       () {},
//                                                     ); // Refresh UI
//                                                   } else {
//                                                     ScaffoldMessenger.of(
//                                                       context,
//                                                     ).showSnackBar(
//                                                       SnackBar(
//                                                         content: Text(
//                                                           'فشل التحديث، حاول مرة أخرى',
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       itemCount: rawatibSunnahList.length,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           ListView.builder(
//                             shrinkWrap: true, // VERY IMPORTANT
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 8.0),
//                                 child: Container(
//                                   width: screenW * 0.84,
//                                   //  height: screenH * 0.1,
//                                   decoration:
//                                       DecorationField.decorationContainer,
//                                   child: ListTile(
//                                     title: Padding(
//                                       padding: EdgeInsets.only(
//                                         right: screenW * 0.02,
//                                       ),
//                                       child: Text(
//                                         textAlign: TextAlign.right,
//                                         sunnahList[index].name,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: textColorM,
//                                         ),
//                                       ),
//                                     ),
//                                     subtitle: Padding(
//                                       padding: EdgeInsets.only(
//                                         right: screenW * 0.02,
//                                       ),
//                                       child: Text(
//                                         textAlign: TextAlign.right,
//                                         "يمكنك ادراج بعض السنن الخفيفة بالبداية",
//                                         style: TextStyle(
//                                           fontSize: 9,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                     leading: Transform.scale(
//                                       scale: 0.8,

//                                       //                         child: Switch(
//                                       //                              value: sunnahList[index].isActive==1?true:false,
//                                       // onChanged:       ),
//                                       child: Switch(
//                                         value: sunnahList[index].isActive == 1,
//                                         onChanged: (value) async {
//                                           final sunnahId = sunnahList[index].id;
//                                           final success =
//                                               value
//                                                   ? await putTurnOn(
//                                                     sunnahId,
//                                                     widget.childId,
//                                                   )
//                                                   : await putTurnOff(
//                                                     sunnahId,
//                                                     widget.childId,
//                                                   );

//                                           if (success) {
//                                             // Re-fetch updated data from server
//                                             await fetchSunnan(); // This updates rawatibSunnahList and sunnahList
//                                             setState(() {}); // Refresh UI
//                                           } else {
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   'فشل التحديث، حاول مرة أخرى',
//                                                 ),
//                                               ),
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     trailing: SizedBox(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             itemCount: sunnahList.length,
//                           ),
//                         ],
//                       ),
//                     ),
//           ),
//         ],
//       ),
//     );
//   }
// }
