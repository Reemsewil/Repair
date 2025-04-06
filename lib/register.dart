import 'package:flutter/material.dart';
import 'package:najati_test/create_child.dart';
import 'package:najati_test/custom_widget.dart';
import 'package:najati_test/main.dart';
import 'package:najati_test/get_child.dart';
import 'package:najati_test/verify.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                            SizedBox(height: screenH * 0.03),
                            // Third and Fourth TextFormFields in one row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "المحافظة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "المنطقة",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
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
                  SizedBox(height: screenH * 0.04),
                  SizedBox(
                    width: screenW * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verification(),
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
