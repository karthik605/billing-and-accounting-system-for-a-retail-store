import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'globals.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'adminpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bas/billing.dart';

late int loginResult;

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://localhost:3001/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userIdController.text,
        'password': passwordController.text,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      loginResult = result['result'];
      if (loginResult == 1) {
        // Admin login
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPage()));
      } else if (loginResult == 2) {
        // Employee login
        // Handle employee login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else if (loginResult == 3) {
        // User not found
        // Handle user not found
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(displayHeight(context));
    // print(displayWidth(context));
    return Container(
      width: 1280 * displayWidth(context) / 1280,
      height: 720 * displayHeight(context) / 595.33,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFF2148C0)),
      child: Stack(
        children: [
          Positioned(
            left: -362,
            top: -1,
            child: Container(
              width: 1641.50 * displayWidth(context) / 1280,
              height: 1083 * displayHeight(context) / 595.33,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 359,
                    child: Container(
                      width: 724 * displayWidth(context) / 1280,
                      height: 724 * displayHeight(context) / 595.33,
                      decoration: ShapeDecoration(
                        color: Color(0xFF264EC9),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 76,
                    top: 435,
                    child: Container(
                      width: 572 * displayWidth(context) / 1280,
                      height: 572 * displayHeight(context) / 595.33,
                      decoration: ShapeDecoration(
                        color: Color(0xFF234BC5),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 143,
                    top: 502,
                    child: Container(
                      width: 438 * displayWidth(context) / 1280,
                      height: 438 * displayHeight(context) / 595.33,
                      decoration: ShapeDecoration(
                        color: Color(0xFF274EC7),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 490,
            top: 161,
            child: Container(
              width: 300 * displayWidth(context) / 1280,
              height: 367 * displayHeight(context) / 595.33,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 80,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/shopcart.svg',
                        width: 119.39 * displayWidth(context) / 1280,
                        height: 97.85 * displayHeight(context) / 595.33,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 169,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 300,
                        height: 45,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 170, top: 6),
                          child: TextFormField(
                            controller: userIdController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              height: 0.10 * displayHeight(context) / 595.33,
                            ),
                            decoration: InputDecoration(
                              hintText: 'USER ID',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                height: 0.10 * displayHeight(context) / 595.33,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical:
                                      12.0), // Adjust vertical padding here
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 234,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 300,
                        height: 45,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 150, top: 6),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: passwordController,
                            obscureText: true, // Hides the entered characters
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              height: 0.10 * displayHeight(context) / 595.33,
                            ),
                            decoration: InputDecoration(
                              hintText: 'PASSWORD',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                height: 0.10 * displayHeight(context) / 595.33,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, right: 10, left: 7),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 322,
                    child: GestureDetector(
                      onTap: () {
                        // Add your login logic here
                        login();
                      },
                      child: Container(
                        width: 300,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x4C000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2148C0),
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              height: 0.08,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 90,
                    top: 0,
                    child: Container(
                      width: 119.39 * displayWidth(context) / 1280,
                      height: 97.85 * displayHeight(context) / 595.33,
                      child: Stack(
                        children: [
                          // You may add child widgets here if needed
                        ],
                      ),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: loginpage(),
  ));
}
