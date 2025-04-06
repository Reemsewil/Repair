import 'package:flutter/material.dart';
import 'package:najati_test/custom_widget.dart';
import 'package:najati_test/main.dart';
import 'package:intl/intl.dart';
import 'package:najati_test/get_child.dart';

class CreateChild extends StatefulWidget {
  const CreateChild({super.key});

  @override
  State<CreateChild> createState() => _CreateChildState();
}

class _CreateChildState extends State<CreateChild> {
  DateTime? selectedDate;
  String? selectedGender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenH * 0.1),
                  Container(
                    width: screenW * 0.9,
                    height: screenH * 0.63,
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
                        padding: const EdgeInsets.all(10.0),
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
                                "اسم الطفل",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),
                            // Second TextFormField with label (Date of Birth)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "تاريخ الميلاد",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),
                            TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text:
                                    selectedDate != null
                                        ? DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(selectedDate!)
                                        : '',
                              ),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                            ),
                            SizedBox(height: screenH * 0.03),
                            // Third TextFormField with label (Gender)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "الجنس",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: screenH * 0.016),
                            TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: selectedGender ?? '',
                              ),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                                prefixIcon: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  onSelected: (String value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context) => [
                                        PopupMenuItem(
                                          value: 'ذكر',
                                          child: Text('ذكر'),
                                        ),
                                        PopupMenuItem(
                                          value: 'انثى',
                                          child: Text('انثى'),
                                        ),
                                      ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenH * 0.04),
                  SizedBox(
                    width: screenW * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetChildren(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("التالي"),
                    ),
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
