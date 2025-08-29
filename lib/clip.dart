import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:najati_test/main.dart';
import 'package:najati_test/models/prayer_times/get_prayer_times.dart';
import 'package:najati_test/top_student.dart';
import 'container.dart';
import 'ty.dart' as q;
import 'core/constants/image_manager.dart';
import 'core/constants/color_manager.dart';
import 'custom_widget.dart';
import 'models/prayers/prayer_times.dart' as r;
import 'services/api/prayer_times.dart';
import 'notifiers.dart';

bool ishaValid = false;
bool maghribValid = false;
bool asrValid = false;
bool duhrValid = false;
bool fajrValid = false;
void debugPrayerWindow(String name, String start, String end) {
  print("Check $name: Now=${DateTime.now()} | From=$start To=$end");
}

bool isNowBetweenCrossDay(String start, String end) {
  final now = DateTime.now();
  final baseDate = DateTime(now.year, now.month, now.day);
  DateTime startTime = _parseTime(start, baseDate);
  DateTime endTime = _parseTime(end, baseDate);

  if (endTime.isBefore(startTime)) {
    endTime = endTime.add(Duration(days: 1));
  }

  return now.isAfter(startTime) && now.isBefore(endTime);
}

DateTime _parseTime(String time, DateTime baseDate) {
  final parts = time.split(":");
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return DateTime(baseDate.year, baseDate.month, baseDate.day, hour, minute);
}

bool isNowAfter(String start, String end) {
  final now = DateTime.now();
  final baseDate = DateTime(now.year, now.month, now.day);

  final startTime = _parseTime(start, baseDate);

  return now.isAfter(startTime);
}

bool isPrayerInProgress(String prayerName) {
  final box = Hive.box<r.PrayerTimes>('prayertimesbox');
  final prayerTimes = box.get(
    'today',
  ); // Assuming you're storing under the key 'today'

  if (prayerTimes == null) return false;

  final timesMap = {
    "الفجر": [prayerTimes.fajr, prayerTimes.sunrise],
    "الظهر": [prayerTimes.dhuhr, prayerTimes.asr],
    "العصر": [prayerTimes.asr, prayerTimes.maghrib],
    "المغرب": [prayerTimes.maghrib, prayerTimes.isha],
    "العشاء": [prayerTimes.isha, prayerTimes.fajr],
  };

  if (!timesMap.containsKey(prayerName)) return false;

  final start = timesMap[prayerName]![0];
  final end = timesMap[prayerName]![1];

  return isNowBetweenProgress(start, end);
}

bool isNowBetweenProgress(String start, String end) {
  final now = DateTime.now();
  final baseDate = DateTime(now.year, now.month, now.day);

  final startTime = _parseTime(start, baseDate);
  var endTime = _parseTime(end, baseDate);

  // If endTime is before startTime, it means the range crosses midnight
  if (endTime.isBefore(startTime)) {
    endTime = endTime.add(Duration(days: 1));
    if (now.isBefore(startTime)) {
      // Adjust "now" if it's after midnight but before startTime
      return now.add(Duration(days: 1)).isBefore(endTime);
    }
  }

  return now.isAfter(startTime) && now.isBefore(endTime);
}

class CustomContainer extends StatefulWidget {
  CustomContainer({
    required this.progress,
    required this.name,
    required this.startedPrayers,
    this.five,
  });
  final double progress;
  final String name;

  GetPrayerTimesResponse? five;
  List<String> startedPrayers;
  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer>
    with SingleTickerProviderStateMixin {
  PrayerTimesServiceImp service = PrayerTimesServiceImp();
  late GetPrayerTimesResponse res;
  bool isLoading = true;
  double progress = 0.0;
  String? selectedStatus;
  bool showOnlySelected = false;
  late AnimationController _animationController;
  late Animation<Alignment> _alignmentAnimation;

  late Animation<double> _animationValue;

  // Color shapeColor =
  //       isBeforePrayerTime ? ColorManager.blackOverlay : ColorManager.whiteColor;
  GetPrayerTimesResponse? five;
  List<String> prayers = [];
  int index = 0;

  static const Color progressStart = Color(0xFF32C9C4);
  static const Color progressEnd = Color(0xFFD2F5F4);
  LinearGradient? getPrayerGradient(String prayerName) {
    switch (prayerName) {
      case "الظهر":
        return LinearGradient(
          colors: ColorManager.validdhuhrGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "العصر":
        return LinearGradient(
          colors: ColorManager.validasrGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "المغرب":
        return LinearGradient(
          colors: ColorManager.validmaghribGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "العشاء":
        return LinearGradient(
          colors: ColorManager.fajrAndIshaGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case "الفجر":
        return LinearGradient(
          colors: ColorManager.fajrAndIshaGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return null;
    }
  }

  Color getBorderColor(String status) {
    switch (status) {
      case "حاضر":
        return const Color(0xFF99F1F1); // أزرق سماوي فاتح
      case "قضاء":
        return const Color(0xFF8635CF); // بنفسجي
      case "فائتة":
        return Colors.orange; // برتقالي افتراضي (غيّره إذا أردت)
      default:
        return Colors.grey;
    }
  }

  String getIconForStatus(String status) {
    switch (status) {
      case "حاضر":
        return ImageManager.present;
      case "قضاء":
        return ImageManager.qada;
      case "فائتة":
        return ImageManager.missed;
      default:
        return ImageManager.present;
    }
  }

  Color getPrayerTextColor(String prayerName) {
    if (widget.startedPrayers.contains(prayerName)) {
      switch (prayerName) {
        case "الظهر":
          return ColorManager.dhrColor;
        case "العصر":
          return ColorManager.asrColor;
        case "المغرب":
          return ColorManager.mgribColor;
        case "العشاء":
        case "الفجر":
          return ColorManager.IshaAndFajrColor;
      }
    }

    // If not valid or unknown prayer name
    return ColorManager.inValidOverlayColor;
  }

  final totalWidth = screenW * 0.35;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationValue = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      updateProgress(); // ✅ تأجيل التحديث حتى تكتمل واجهة المستخدم

      // ✅ تشغيل التحديث كل 30 ثانية بعد أول تنفيذ
      Timer.periodic(const Duration(seconds: 30), (_) => updateProgress());
    });
  }

  DateTime _parseTime(String time, DateTime base) {
    final parts = time.split(":");
    return DateTime(
      base.year,
      base.month,
      base.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  String _getPrayerStart(String? name, prayerTimes) {
    switch (name) {
      case "الفجر":
        return prayerTimes.fajr;
      case "الظهر":
        return prayerTimes.dhuhr;
      case "العصر":
        return prayerTimes.asr;
      case "المغرب":
        return prayerTimes.maghrib;
      case "العشاء":
        return prayerTimes.isha;
      default:
        return "00:00";
    }
  }

  String? getCurrentValidPrayer() {
    final box = Hive.box<r.PrayerTimes>('prayertimesbox');
    final prayerTimes = box.get('today');

    if (prayerTimes == null) {
      log("reeem is here hello how are you");
      log("6");
      return null;
    }

    log("reeem is here hello how are you");
    log(prayerTimes!.asr);

    final times = {
      "الفجر": [prayerTimes.fajr, prayerTimes.sunrise],
      "الظهر": [prayerTimes.dhuhr, prayerTimes.asr],
      "العصر": [prayerTimes.asr, prayerTimes.maghrib],
      "المغرب": [prayerTimes.maghrib, prayerTimes.isha],
      "العشاء": [prayerTimes.isha, prayerTimes.fajr], // crosses midnight
    };

    for (final entry in times.entries) {
      final name = entry.key;
      final start = entry.value[0];
      final end = entry.value[1];
      if (isNowBetweenProgress(start, end)) {
        log("isNowBetweenProgress(start, end)");
        log(isNowBetweenProgress(start, end).toString());
        return name;
      }
    }
    log("we will return null");

    return null; // No valid prayer time now
  }

  void updateProgress() {
    final box = Hive.box<r.PrayerTimes>('prayertimesbox');
    final cachedPrayerTimes = box.get('today');

    final times = cachedPrayerTimes; // تأكد أن five معرف
    final valid = getCurrentValidPrayer();
    final start = _getPrayerStart(valid, times);
    final end = _getPrayerEnd(valid, times);

    final now = DateTime.now();
    final startTime = _parseTime(start, now);
    var endTime = _parseTime(end, now);

    if (endTime.isBefore(startTime)) {
      endTime = endTime.add(const Duration(days: 1));
    }

    if (now.isBefore(startTime) || now.isAfter(endTime)) {
      progress = 0;
    } else {
      final total = endTime.difference(startTime).inSeconds;
      final current = now.difference(startTime).inSeconds;
      progress = current / total;
    }
    if (mounted) {
      setState(() {});
    }
  }

  String _getPrayerEnd(String? name, prayerTimes) {
    switch (name) {
      case "الفجر":
        return prayerTimes.sunrise;
      case "الظهر":
        return prayerTimes.asr;
      case "العصر":
        return prayerTimes.maghrib;
      case "المغرب":
        return prayerTimes.isha;
      case "العشاء":
        return prayerTimes.fajr; // العشاء ينتهي عند الفجر
      default:
        return "00:00";
    }
  }

  void handleSelection(String status) {
    setState(() {
      selectedStatus = status;
    });

    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        _animationController.forward();
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showOnlySelected = true;
      });
    });
  }

  Object getPrayerContainerColor(String prayerName) {
    switch (prayerName) {
      case "الظهر":
        return duhrValid
            ? ColorManager.validdhuhrGradient
            : ColorManager.inValidOverlayColor;
      case "العصر":
        return asrValid
            ? ColorManager.validasrGradient
            : ColorManager.inValidOverlayColor;
      case "المغرب":
        return maghribValid
            ? ColorManager.validmaghribGradient
            : ColorManager.inValidOverlayColor;
      case "العشاء":
        return ishaValid
            ? ColorManager.fajrAndIshaGradient
            : ColorManager.inValidOverlayColor;
      case "الفجر":
        return fajrValid
            ? ColorManager.fajrAndIshaGradient
            : ColorManager.inValidOverlayColor;
      default:
        return Colors.white;
    }
  }

  LinearGradient? getStatusGradient(String? status) {
    switch (status) {
      case 'حاضر':
        return LinearGradient(
          colors: [
            const Color.fromARGB(255, 144, 236, 229),
            const Color.fromARGB(255, 79, 243, 216),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [_animationValue.value, _animationValue.value + 0.001],
        );
      case 'قضاء':
        return LinearGradient(
          colors: [
            Colors.purple.shade300,
            const Color.fromARGB(255, 136, 77, 173),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [_animationValue.value, _animationValue.value + 0.001],
        );
      case 'فائتة':
        return LinearGradient(
          colors: [
            Colors.orange.shade300,
            const Color.fromARGB(255, 243, 168, 107),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [_animationValue.value, _animationValue.value + 0.001],
        );
      default:
        return null; // أو return LinearGradient(...) للون افتراضي
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textColor;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: screenH * 0.11,
            width: screenW * 0.91,
            decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white, width: 2),
              // border: Border.all(
              //   color: selectedStatus != null ? Colors.blue : Colors.white,
              //   width: selectedStatus != null ? 4 : 2,
              // ),
              border:
                  selectedStatus != null
                      ? Border.all(
                        width: 1.5,
                        color: getBorderColor(selectedStatus!),
                      )
                      : null,
              gradient:
                  selectedStatus != null
                      ? getStatusGradient(selectedStatus)
                      : null,

              color: selectedStatus == null ? Color(0xFFE4ECFC) : null,
              borderRadius: BorderRadius.circular(17),
              //  color: Color(0xFFE4ECFC), // Main container background
            ),
            child: Row(
              children: [
                if (showOnlySelected && selectedStatus != null)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: screenW * 0.2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedStatus!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),

                            Image.asset(
                              getIconForStatus(selectedStatus!),
                              width: 27,
                              height: 27,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  // Right Section: Icons and Progress Indicator
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            showOnlySelected && selectedStatus != null
                                ? SizedBox()
                                : PrayerColumn(
                                  imagePath: ImageManager.present,
                                  text: "حاضر",
                                  name: widget.name,
                                  startedPrayer: widget.startedPrayers,
                                  onSelected: handleSelection,
                                  showBorder: selectedStatus == "حاضر",
                                ),
                            showOnlySelected && selectedStatus != null
                                ? SizedBox()
                                : isPrayerInProgress(widget.name)
                                ? PrayerColumn(
                                  imagePath: ImageManager.qada,
                                  text: "قضاء",
                                  name: widget.name,
                                  startedPrayer: widget.startedPrayers,
                                  onSelected: handleSelection,
                                  showBorder: selectedStatus == "قضاء",
                                )
                                : showOnlySelected && selectedStatus != null
                                ? SizedBox()
                                : PrayerColumn(
                                  imagePath: ImageManager.missed,
                                  text: "فائتة",
                                  startedPrayer: widget.startedPrayers,

                                  name: widget.name,
                                  onSelected: handleSelection,
                                  showBorder: selectedStatus == "فائتة",
                                ),
                          ],
                        ),
                        widget.startedPrayers.contains(widget.name) &&
                                !isPrayerInProgress(widget.name)
                            ? SizedBox()
                            : isPrayerInProgress(widget.name) &&
                                (showOnlySelected && selectedStatus != null)
                            ? SizedBox()
                            : isPrayerInProgress(widget.name) &&
                                !(showOnlySelected && selectedStatus != null)
                            ? Container(
                              height: 5,
                              width: totalWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.grey[300],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: totalWidth * progress,
                                      decoration: BoxDecoration(
                                        //  color:

                                        // ColorManager.inValidOverlayColor,
                                        gradient: LinearGradient(
                                          colors: [
                                            progressStart,
                                            const Color.fromARGB(
                                              255,
                                              159,
                                              146,
                                              204,
                                            ),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : (!widget.startedPrayers.contains(widget.name)) &&
                                (showOnlySelected && selectedStatus != null)
                            ? SizedBox()
                            : (!widget.startedPrayers.contains(widget.name)) &&
                                !(showOnlySelected && selectedStatus != null)
                            ? Container(
                              height: 5,
                              width: totalWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.grey[300],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    // child: Container(
                                    //   width:
                                    //       widget.prayerNameValid == widget.name
                                    //           ? totalWidth * progress
                                    //           : 150,
                                    //   decoration: BoxDecoration(
                                    //     color:
                                    //         widget.prayerNameValid == widget.name
                                    //             ? null
                                    //             : ColorManager.inValidOverlayColor,
                                    //     gradient:
                                    //         widget.prayerNameValid == widget.name
                                    //             ? LinearGradient(
                                    //               colors: [
                                    //                 progressStart,
                                    //                 const Color.fromARGB(
                                    //                   255,
                                    //                   159,
                                    //                   146,
                                    //                   204,
                                    //                 ),
                                    //               ],
                                    //               begin: Alignment.centerLeft,
                                    //               end: Alignment.centerRight,
                                    //             )
                                    //             : null,
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                Flexible(
                  child: Container(
                    width: screenW * 0.5,
                    height: screenH * 0.11,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            right: -65,
                            bottom: -36,
                            top: -17,
                            child: SizedBox(
                              height: 220,
                              width: 220,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      widget.startedPrayers.contains(
                                            widget.name,
                                          )
                                          ? null
                                          : ColorManager.inValidOverlayColor,
                                  gradient:
                                      widget.startedPrayers.contains(
                                            widget.name,
                                          )
                                          ? getPrayerGradient(widget.name)
                                          : null,
                                ),
                              ),
                            ),
                          ),
                          // Prayer Name
                          Positioned(
                            right: 16,
                            top: screenH * 0.04,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: getPrayerTextColor(widget.name),
                                //  prayrrnamevalid
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Positioned widgets for each prayer
                          Positioned(
                            bottom: 20,
                            right: 80,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                // color:
                                //     widget.isBeforePrayerTime
                                //         ? ColorManager.blackOverlay
                                //         : ColorManager.sunsetOrange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),

                          Positioned(
                            //  top: 50, //half container height
                            right: 80,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                //   color: widget.shapeColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 25,
                            right: 75,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                //color: widget.shapeColor,
                                shape: BoxShape.circle,
                                //
                              ),
                            ),
                          ),

                          widget.name == "الفجر"
                              ? _buildFajrShape(
                                widget.startedPrayers,
                                widget.name,
                              )
                              : widget.name == "الظهر"
                              ? _buildDhuhrShape(
                                widget.startedPrayers,
                                widget.name,
                              )
                              : widget.name == "العصر"
                              ? _buildAsrShape(
                                widget.startedPrayers,
                                widget.name,
                              )
                              : widget.name == "المغرب"
                              ? _buildMaghribShape(
                                widget.startedPrayers,
                                widget.name,
                              )
                              : widget.name == "العشاء"
                              ? _buildIshaShape(
                                widget.startedPrayers,
                                widget.name,
                              )
                              : SizedBox(),
                        ],
                      ),
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

class PrayerContainer extends StatefulWidget {
  PrayerContainer({super.key, required this.childId});

  int childId;
  @override
  State<PrayerContainer> createState() => _PrayerContainerState();
}

class _PrayerContainerState extends State<PrayerContainer> {
  double progress = 0.3;
  String prayerNameValid = "";
  bool x = false;
  GetPrayerTimesResponse? five;
  List<String> startedPrayers = [];
  // String? getCurrentValidPrayerName() {
  //   final Map<String, bool> validityMap = {
  //     for (var name in ["الفجر", "الظهر", "العصر", "المغرب", "العشاء"])
  //       name: isPrayerTimeValid(name),
  //   };

  //   log("im in getcurrent");
  //   for (final entry in validityMap.entries) {
  //     log("the valid prayer is ===== ${entry}");

  //     if (entry.value) {
  //       log("the valid prayer is ===== ${entry.value}");
  //       return entry.key; // return the first valid prayer name
  //     }
  //   }
  //   return null;
  // }

  List<String> getValidPrayerNames() {
    final times = five!.data.prayerTimes;

    final Map<String, String> startTimes = {
      "الفجر": times.fajr,
      "الظهر": times.dhuhr,
      "العصر": times.asr,
      "المغرب": times.maghrib,
      "العشاء": times.isha,
    };

    final now = DateTime.now();
    final baseDate = DateTime(now.year, now.month, now.day);

    List<String> validPrayers = [];

    for (final entry in startTimes.entries) {
      final startTime = _parseTime(entry.value, baseDate);
      if (now.isAfter(startTime)) {
        validPrayers.add(entry.key);
      }
    }
    log(validPrayers[0]);
    log("reeeeeeeeeeeeeeddddddddddddddddddd");
    return validPrayers;
  }

  void loadData() async {
    try {
      isLoading = true;

      log("im in loaddatea");
      print("========================++++++++++reeeem===============");
      //شيل الكومنت لما يصير الريكويست صح
      // final response = await service.getPrayerTimes();
      // log(response.data.prayerTimes.asr);

      // For mock (no server needed)
      final service = PrayerTimesServiceMock();

      final response = await service.getPrayerTimes();

      log("Maraba");

      five = response;
      final apiPrayerTimes = response.data.prayerTimes;

      final hivePrayerTimes = r.PrayerTimes(
        fajr: apiPrayerTimes.fajr,
        sunrise: apiPrayerTimes.sunrise,
        dhuhr: apiPrayerTimes.dhuhr,
        asr: apiPrayerTimes.asr,
        sunset: apiPrayerTimes.sunset,
        maghrib: apiPrayerTimes.maghrib,
        isha: apiPrayerTimes.isha,
        imsak: apiPrayerTimes.imsak,
        midnight: apiPrayerTimes.midnight,
        firstthird: apiPrayerTimes.firstThird,
        lastthird: apiPrayerTimes.lastThird,
      );

      final prayerBox = Hive.box<r.PrayerTimes>('prayertimesbox');

      await prayerBox.put('today', hivePrayerTimes);

      startedPrayers = getValidPrayerNames();
      // ishaValid = isPrayerTimeValid("العشاء");
      // fajrValid = isPrayerTimeValid("الفجر");
      // maghribValid = isPrayerTimeValid("المغرب");
      // asrValid = isPrayerTimeValid("العصر");
      // duhrValid = isPrayerTimeValid("الظهر");
      log(prayerNameValid);

      log(fajrValid.toString());
      log("im heeeeeeeeeeeeeeeeeeeeeeeeereeeeeeeeeeeeeeeeeee");

      log(prayerNameValid);

      setState(() {
        isLoading = false;

        log("++++++++++++++++++++++++++++++++++++++=");
        log(prayerNameValid!);
      });
    } catch (e) {
      print("API call failed: $e");

      setState(() {
        isLoading = false; // Also set it to false on error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    log("+++before request +++++++");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
      isLoading = false;
    });
    log("+++before request +++++++");
  }

  PrayerTimesServiceImp service = PrayerTimesServiceImp();
  late GetPrayerTimesResponse res;
  int index = 0;
  List<String> fiveSalat = ["الفجر", "الظهر", "العصر", "المغرب", "العشاء"];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFDEE9FD),
        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: showRTTWidget,
                      builder: (context, value, child) {
                        return value
                            ? TopRightCircleTasbeeh() // Your replacement widget
                            : TopRightCircleChild();
                      },
                    ),
                    LeftBottomCircle(),
                    WinCircle(childId: widget.childId),
                    QuestionCircle(),
                    RightBottomCircle(),

                    // Scrollable content
                    Positioned.fill(
                      top: 320, // Or wherever you want content to start
                      child: ListView(
                        // padding: EdgeInsets.all(16),
                        children: [
                          CustomContainer(
                            progress: 0.3,
                            name: fiveSalat[0],
                            startedPrayers: startedPrayers,
                            five: five,
                          ),

                          CustomContainer(
                            progress: 0.3,
                            name: fiveSalat[1],
                            startedPrayers: startedPrayers,
                            five: five,
                          ),

                          CustomContainer(
                            progress: 0.3,
                            name: fiveSalat[2],
                            startedPrayers: startedPrayers,
                            five: five,
                          ),

                          CustomContainer(
                            progress: 0.3,
                            name: fiveSalat[3],
                            startedPrayers: startedPrayers,
                            five: five,
                          ),
                          CustomContainer(
                            progress: 0.3,
                            name: fiveSalat[4],
                            startedPrayers: startedPrayers,
                            five: five,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

Widget _buildFajrShape(List<String> prayerValid, String name) {
  return Positioned(
    top: 10,
    right: 5,
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.1416),
      child: Icon(
        Icons.nightlight_round_outlined,
        color:
            prayerValid.contains(name)
                ? Colors.white
                : ColorManager.blackOverlay,
        size: 16,
      ),
    ),
  );
}

Widget _buildDhuhrShape(List<String> prayerValid, String name) {
  return Positioned(
    top: screenW * 0.02,
    left: screenW * 0.25,
    child: Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color:
            prayerValid.contains(name)
                ? Colors.white
                : ColorManager.blackOverlay,

        shape: BoxShape.circle,
        // boxShadow:
        //     isBeforePrayerTime
        //         ? []
        //         : [
        //           BoxShadow(
        //             color: ColorManager.whiteColor,
        //             blurRadius: 10,
        //             spreadRadius: 3,
        //           ),
        //         ],
      ),
    ),
  );
}

class PrayerColumn extends StatefulWidget {
  final String imagePath;
  final String text;
  final void Function(String) onSelected;

  final bool showBorder;
  PrayerColumn({
    super.key,
    required this.imagePath,
    required this.text,
    required this.startedPrayer,
    required this.name,
    required this.onSelected,
    required this.showBorder,
  });
  List<String> startedPrayer;
  String name;

  @override
  State<PrayerColumn> createState() => _PrayerColumnState();
}

class _PrayerColumnState extends State<PrayerColumn> {
  bool isSelected = false;

  List<BoxShadow>? getCircularShadowByStatus(String status) {
    switch (status) {
      case "حاضر":
        return [
          BoxShadow(
            color: const Color.fromARGB(255, 128, 237, 252).withOpacity(0.6),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ];
      case "قضاء":
        return [
          BoxShadow(
            color: const Color(0xFF8635CF).withOpacity(0.6),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ];
      case "فائتة":
        return [
          BoxShadow(
            color: const Color(0xFFFF914D).withOpacity(0.6),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.startedPrayer.contains(widget.name)) {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onSelected(widget.text);
          log("========================");
          log(widget.showBorder.toString());
          if (widget.text == "قضاء") {
            Future.delayed(Duration(seconds: 1), () {
              showRTTWidget.value = true;
            });
          } else {
            showRTTWidget.value = false;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                color:
                    widget.startedPrayer.contains(widget.name)
                        ? Colors.black
                        : ColorManager.blackOverlay,
              ),
            ),

            (widget.showBorder)
                ? Container(
                  width: 30, // أكبر قليلاً من الأيقونة
                  height: 30,
                  decoration: BoxDecoration(
                    //   color: Colors.yellow,
                    shape: BoxShape.circle,
                    // border: Border.all(color: Colors.white),
                    boxShadow: getCircularShadowByStatus(widget.text),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(color: Colors.white),
                      //   color: Colors.red,
                    ),

                    child: Image.asset(
                      widget.imagePath,
                      width: 26,
                      height: 26,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                : Image.asset(
                  widget.imagePath,
                  color:
                      widget.text == "فائتة"
                          ? widget.startedPrayer.contains(widget.name)
                              ? null
                              : ColorManager.inValidOverlayColor
                          : widget.text == "حاضر"
                          ? widget.startedPrayer.contains(widget.name)
                              ? null
                              : ColorManager.inValidOverlayColor
                          : widget.text == "قضاء"
                          ? widget.startedPrayer.contains(widget.name)
                              ? null
                              : ColorManager.inValidOverlayColor
                          : null,

                  //  width: widget.imagePath == ImageManager.missed ? 25 : 35,
                  //height: widget.imagePath == ImageManager.missed ? 20 : 30,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error');
                    return const SizedBox(height: 5);
                  },
                ),
            widget.imagePath == ImageManager.missed
                ? SizedBox(height: 1.5)
                : SizedBox(),

            //  const SizedBox(height: 2),
            // const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}

Widget _buildAsrShape(List<String> prayerValid, String name) {
  return Positioned(
    top: screenW * 0.09, //half container height
    right: screenW * 0.23,
    child: Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color:
            prayerValid.contains(name)
                ? Colors.white
                : ColorManager.blackOverlay,

        shape: BoxShape.circle,
        // boxShadow:
        //     isBeforePrayerTime
        //         ? []
        //         : [
        //           BoxShadow(
        //             color: ColorManager.whiteColor,
        //             blurRadius: 20,
        //             spreadRadius: 1,
        //           ),
        //         ],
      ),
    ),
  );
}

Widget _buildMaghribShape(List<String> prayerValid, String name) {
  return Positioned(
    bottom: 10,
    right: 90,
    child: Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color:
            prayerValid.contains(name)
                ? ColorManager.sunsetOrange
                : ColorManager.blackOverlay,
        shape: BoxShape.circle,
      ),
    ),
  );
}
// Widget _buildFajrShape(Color shapeColor) {
//   return Positioned(
//     top: 20,
//     right: 20,
//     child: Transform(
//       alignment: Alignment.center,
//       transform: Matrix4.rotationY(3.1416),
//       child: Icon(
//         Icons.nightlight_round_outlined,
//         color: shapeColor,
//         size: 15,
//       ),
//     ),
//   );
// }

Widget _buildIshaShape(List<String> prayerValid, String name) {
  return Positioned(
    top: 20,
    right: 80,
    child: Icon(
      Icons.auto_awesome,
      color:
          prayerValid.contains(name) ? Colors.white : ColorManager.blackOverlay,

      size: 20,
    ),
  );
}


//  Container(
//                     height: 5,
//                     width: screenW * 0.35,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(17),
//                       color: Colors.grey, // Background for visibility
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           child: Container(
//                             width: 200 * widget.progress,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.pink,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),