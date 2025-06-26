import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/color_manager.dart';
import 'package:najati_test/create_child.dart';
import 'core/constants/image_manager.dart';
import 'core/constants/url_manager.dart';
import 'core/widgets/textfield_common.dart';
import 'custom_widget.dart';
import 'main.dart';
import 'models/profile_settings.dart';
import 'najati/statistics_.dart';
import 'services/api/profile_settings_api.dart';
import 'statistics/view/statistics.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool hasShownError = false;

  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<ParentProfileResponse?> profileResponse = ValueNotifier(
    null,
  );
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  final ParentProfileService service = ParentProfileService();

  void getProfileData() async {
    try {
      isLoading.value = true;

      final response = await service.fetchParentProfile();

      profileResponse.value = response;
    } catch (e) {
      print("Error: $e");
      profileResponse.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (profileResponse.value == null && !isLoading.value && !hasShownError) {
      // Only show snackbar once
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("فشل تحميل الملف الشخصي")),
          );
        }
      });
      hasShownError = true; // prevent repeated showing
    }

    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, loading, _) {
          if (loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<ParentProfileResponse?>(
            valueListenable: profileResponse,
            builder: (context, response, _) {
              if (response == null) {
                if (!hasShownError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("فشل تحميل الملف الشخصي")),
                      );
                    }
                  });
                  hasShownError = true;
                }
              }

              return Stack(
                children: [
                  TopRightCircle(),
                  LeftBottomCircle(),
                  RightBottomCircle(),
                  Positioned(
                    right: 5,
                    top: screenH * 0.12,
                    bottom: 20,
                    left: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SizedBox(height: screenH * 0.1),
                          SizedBox(height: screenH * 0.1),
                          Container(
                            width: screenW * 0.9,
                            height: screenH * 0.63,
                            decoration: DecorationField.decorationContainer,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Boo image
                                  Image.asset(
                                    profileResponse.value!.data.paid == true
                                        ? ImageManager.activeImage
                                        : ImageManager.noImage,
                                    height: screenH * 0.12,
                                    fit: BoxFit.contain,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      profileResponse.value!.data.name,
                                    ),
                                  ),
                                  SizedBox(height: screenH * 0.03),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          profileResponse
                                              .value!
                                              .data
                                              .children
                                              .length,
                                      itemBuilder: (context, index) {
                                        final child =
                                            profileResponse
                                                .value!
                                                .data
                                                .children[index];

                                        return
                                        // First TextFormField with label
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => Statistics(
                                                      childId: child.id,
                                                      nameChild: child.name,
                                                      imageChild:
                                                          child.character.image,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              width: screenW * 0.88,
                                              height: screenH * 0.08,
                                              decoration:
                                                  DecorationField
                                                      .decorationContainer,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Text(
                                                      child.name,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            profileResponse
                                                                        .value!
                                                                        .data
                                                                        .paid ==
                                                                    true
                                                                ? Colors.black
                                                                : ColorManager
                                                                    .blackOverlay,
                                                      ),
                                                      //  softWrap: true,
                                                      //overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12.0,
                                                        ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      height: screenH * 0.13,
                                                      width: screenW * 0.09,
                                                      //      fit: BoxFit.contain,
                                                      child:
                                                          child.character != []
                                                              ? Image.network(
                                                                "${UrlManager.baseUrl}${child.character.image}",
                                                                color:
                                                                    profileResponse.value!.data.paid ==
                                                                            true
                                                                        ? null
                                                                        : ColorManager
                                                                            .blackOverlay,
                                                                width: 40,
                                                                height: 40,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                                errorBuilder: (
                                                                  context,
                                                                  error,
                                                                  stackTrace,
                                                                ) {
                                                                  return const Icon(
                                                                    Icons
                                                                        .broken_image,
                                                                  );
                                                                },
                                                              )
                                                              : Icon(
                                                                Icons
                                                                    .broken_image,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CreateChild(profileResponse.value!.data.name),
              ),
            );
          },
          shape: const CircleBorder(),

          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
