import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'globals.dart';
import 'billing.dart';
import 'inventory.dart';
import 'report.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: 1280 * displayWidth(context) / 1280,
          height: 720 * displayHeight(context) / 595.33,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1280 * displayWidth(context) / 1280,
                  height: 105 * displayHeight(context) / 595.33,
                  padding: const EdgeInsets.symmetric(vertical: 23),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFF264EC9)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 249 * displayWidth(context) / 1280,
                        height: 59 * displayHeight(context) / 595.33,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(
                            'Hello Admin!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 515,
                top: 205,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Container(
                    width: 200 * displayWidth(context) / 1280,
                    height: 82 * displayHeight(context) / 595.33,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Container(
                            width: 198 * displayWidth(context) / 1280,
                            height: 80 * displayHeight(context) / 595.33,
                            decoration: ShapeDecoration(
                              color: Color(0xFF264EC9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 47,
                          top: 17,
                          child: SizedBox(
                            width: 105 * displayWidth(context) / 1280,
                            height: 50 * displayHeight(context) / 595.33,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                'Billing',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 515,
                top: 340,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportPage()),
                    );
                  },
                  child: Container(
                    width: 200 * displayWidth(context) / 1280,
                    height: 82 * displayHeight(context) / 595.33,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Container(
                            width: 198 * displayWidth(context) / 1280,
                            height: 80 * displayHeight(context) / 595.33,
                            decoration: ShapeDecoration(
                              color: Color(0xFF264EC9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 47,
                          top: 17,
                          child: SizedBox(
                            width: 105 * displayWidth(context) / 1280,
                            height: 50 * displayHeight(context) / 595.33,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                'Reports',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 515,
                top: 475,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InventoryPage()),
                    );
                  },
                  child: Container(
                    width: 200 * displayWidth(context) / 1280,
                    height: 82 * displayHeight(context) / 595.33,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Container(
                            width: 198 * displayWidth(context) / 1280,
                            height: 80 * displayHeight(context) / 595.33,
                            decoration: ShapeDecoration(
                              color: Color(0xFF264EC9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 47,
                          top: 17,
                          child: SizedBox(
                            width: 105 * displayWidth(context) / 1280,
                            height: 50 * displayHeight(context) / 595.33,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                'Inventory',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0.04,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
