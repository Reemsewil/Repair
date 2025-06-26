import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:najati_test/core/constants/url_manager.dart';
import 'package:najati_test/custom_widget.dart';
import 'package:najati_test/features/Auth/data/data_sources/remote_data_source.dart';
import 'package:najati_test/main.dart';
import 'package:najati_test/verify.dart';

import 'features/Auth/data/model/register_request_model.dart';
import 'models/location/location.dart';

final dropdownDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.white),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.white),
  ),
  filled: true,
  fillColor: Colors.transparent,
);

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController governorateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController districtController = TextEditingController();

  final TextEditingController townController = TextEditingController();

  // List<Governorate> governorates = [];
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    governorateController.dispose();
    cityController.dispose();
    districtController.dispose();
    townController.dispose();
    super.dispose();
  }

  bool isLoading = false;
  late final LocationService locationService;

  Governorate? selectedGovernorate;
  City? selectedCity;
  District? selectedDistrict;
  Town? selectedTown;

  List<Governorate> governorates = [];
  List<City> cities = [];
  List<District> districts = [];
  List<Town> towns = [];

  @override
  void initState() {
    super.initState();
    locationService = LocationService();

    fetchGovernorates();
  }

  // _Exception (Exception: Failed to load governorates: DioException [connection error]: The connection errored: Connection failed This indicates an error which most likely cannot be solved by the library.
  // Error: SocketException: Connection failed (OS Error: Network is unreachable, errno = 101), address = najati.webmyidea.com, port = 443)

  Future<void> fetchGovernorates() async {
    governorates = await locationService.fetchLocationList(
      '${UrlManager.baseUrl}/api/locations/governorates',
      'governorates',
      (json) => Governorate.fromJson(json),
    );
    setState(() {});
  }

  Future<void> fetchCities(String governorate) async {
    cities = await locationService.fetchLocationList(
      '${UrlManager.baseUrl}/api/locations/cities?governorate=${Uri.encodeComponent(governorate)}',
      'cities',
      (json) => City.fromJson(json),
    );
    setState(() {});
  }

  Future<void> fetchDistricts(String governorate, String city) async {
    districts = await locationService.fetchLocationList(
      '${UrlManager.baseUrl}/api/locations/districts?governorate=${Uri.encodeComponent(governorate)}&city=${Uri.encodeComponent(city)}',
      'districts',
      (json) => District.fromJson(json),
    );
    setState(() {});
  }

  Future<void> fetchTowns(
    String governorate,
    String city,
    String district,
  ) async {
    towns = await locationService.fetchLocationList(
      '${UrlManager.baseUrl}/api/locations/towns?governorate=${Uri.encodeComponent(governorate)}&city=${Uri.encodeComponent(city)}&district=${Uri.encodeComponent(district)}',
      'towns',
      (json) => Town.fromJson(json),
    );
    setState(() {});
  }

  // @override
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: screenH * 0.1),
                  Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: screenH * 0.1),
                  Container(
                    width: screenW * 0.9,
                    height: screenH * 0.81,
                    decoration: BoxDecoration(
                      color: Color(0x73C2CEE3).withOpacity(0.45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 18,
                          color: Color(0x73C2CEE3).withOpacity(0.45),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Boo image
                            Image.asset(
                              'assets/images/Boo.png',
                              height: screenH * 0.12,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: screenH * 0.03),

                            // First TextFormField with label
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "اسم ولي الامر",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),

                            TextFormField(
                              textAlign: TextAlign.end,
                              controller: nameController,
                              style: TextStyle(color: Colors.black),
                              decoration: dropdownDecoration,
                            ),
                            SizedBox(height: screenH * 0.016),
                            // Second TextFormField with label
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "رقم الموبايل",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              style: TextStyle(color: Colors.black),
                              decoration: dropdownDecoration,
                            ),
                            SizedBox(height: screenH * 0.03),
                            // Third and Fourth TextFormFields in one row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "المدينة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<City>(
                                        isExpanded: true,
                                        value: selectedCity,
                                        items:
                                            cities.map((city) {
                                              return DropdownMenuItem(
                                                value: city,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,

                                                  child: Text(
                                                    city.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              );
                                            }).toList(),

                                        onChanged: (value) async {
                                          setState(() {
                                            selectedCity = value;
                                            selectedDistrict = null;
                                            selectedTown = null;
                                            cityController.text =
                                                value?.name ?? '';
                                            districts.clear();
                                            towns.clear();
                                          });
                                          if (value != null &&
                                              selectedGovernorate != null) {
                                            await fetchDistricts(
                                              selectedGovernorate!.name,
                                              value.name,
                                            );
                                          }
                                        },
                                        decoration: dropdownDecoration,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "المحافظة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<Governorate>(
                                        isExpanded:
                                            true, // ✅ Prevents horizontal overflow
                                        //      itemHeight: 50,
                                        value: selectedGovernorate,
                                        items:
                                            governorates.map((governorate) {
                                              return DropdownMenuItem(
                                                value: governorate,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,

                                                  child: Text(
                                                    governorate.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (value) async {
                                          setState(() {
                                            selectedGovernorate = value;
                                            selectedCity = null;
                                            selectedDistrict = null;
                                            selectedTown = null;
                                            governorateController.text =
                                                value?.name ?? '';
                                            cities.clear();
                                            districts.clear();
                                            towns.clear();
                                          });
                                          if (value != null) {
                                            await fetchCities(value.name);
                                          }
                                        },
                                        decoration: dropdownDecoration,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenH * 0.016),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "البلدة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<Town>(
                                        isExpanded:
                                            true, // ✅ Prevents horizontal overflow

                                        value: selectedTown,
                                        items:
                                            towns.map((town) {
                                              return DropdownMenuItem(
                                                value: town,
                                                child: FittedBox(
                                                  child: Text(
                                                    town.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            townController.text =
                                                value?.name ?? '';
                                            selectedTown = value;
                                          });
                                        },
                                        decoration: dropdownDecoration,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "المنطقة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      SingleChildScrollView(
                                        child: DropdownButtonFormField<
                                          District
                                        >(
                                          isExpanded: true,
                                          value: selectedDistrict,
                                          items:
                                              districts.map((district) {
                                                return DropdownMenuItem(
                                                  value: district,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,

                                                    child: Text(
                                                      district.name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                          onChanged: (value) async {
                                            setState(() {
                                              selectedDistrict = value;
                                              selectedTown = null;
                                              districtController.text =
                                                  value?.name ?? '';
                                              towns.clear();
                                            });
                                            if (value != null &&
                                                selectedGovernorate != null &&
                                                selectedCity != null) {
                                              await fetchTowns(
                                                selectedGovernorate!.name,
                                                selectedCity!.name,
                                                value.name,
                                              );
                                            }
                                          },
                                          decoration: dropdownDecoration,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenH * 0.06),
                  SizedBox(
                    height: screenH * 0.06,

                    width: screenW * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final model = RegisterRequestModel(
                          name: nameController.text.trim(),
                          phone: phoneController.text.trim(),
                          governorate: governorateController.text.trim(),
                          city: cityController.text.trim(),
                          district: districtController.text.trim(),
                          town: townController.text.trim(),
                        );
                        print("im in herrrrrrrrrrrrre");
                        print(
                          'RegisterRequestModel: '
                          'name: ${model.name}, '
                          'phone: ${model.phone}, '
                          'governorate: ${model.governorate}, '
                          'city: ${model.city}, '
                          'district: ${model.district}, '
                          'town: ${model.town}',
                        );
                        final reg = RegisterService();

                        final isSuccess = await reg.register(model);

                        if (isSuccess) {
                          isLoading = false;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Verification(phone: phoneController.text),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("فشل التسجيل، حاول مرة أخرى"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Text("التالي"),
                    ),
                  ),
                  SizedBox(height: screenH * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
