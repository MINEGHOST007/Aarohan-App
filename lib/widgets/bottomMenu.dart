import 'dart:ui';

import 'package:aarohan_app/resources/eurekoin.dart';
import 'package:aarohan_app/widgets/menuItems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/coming_soon.dart';
import '../models/user.dart';
import '../services/auth_services.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  double sigmaX = 0;
  double sigmaY = 0;
  getuser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    AuthService authService = AuthService();
    await authService.storeUser(_auth.currentUser!);
  }

  List<String> menuBarIconsUnSelected = [
    'assets/menuBarSettings0.png',
    'assets/menuBarPerson0.png',
    'assets/menuBarConsole0.png'
  ];
  List<String> menuBarIconsSelected = [
    'assets/menuBarSettings1.png',
    'assets/menuBarPerson1.png',
    'assets/menuBarConsole1.png'
  ];
  String settingIcon = 'assets/menuBarSettings0.png';
  String personIcon = 'assets/menuBarPerson0.png';
  String consoleIcon = 'assets/menuBarConsole0.png';
  late String eurekoinRoute;

  final _firestore = FirebaseFirestore.instance;
  String? JDTitle;
  ValueNotifier<bool> prelims = ValueNotifier(false);
  ValueNotifier<bool> interfecio = ValueNotifier(false);
  ValueNotifier<bool> isInterficioAvailable = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _firestore.collection('Events').doc('Journo Detective').get().then((value) {
      setState(() {
        if (value.exists) {
          JDTitle = value.data()?["title"];
        } else {
          print(0);
        }
      });
    });
    _firestore.collection('Coming Soon').doc('Prelims').get().then((value) {
      setState(() {
        if (value.exists) {
          prelims.value = value.data()?["flag"];
        } else {
          // print(prelims);
        }
      });
    });
    _firestore
        .collection('Coming Soon')
        .doc('Journo Detective')
        .get()
        .then((value) {
      setState(() {
        if (value.exists) {
          interfecio.value = value.data()?["flag"];
        } else {
          // debugPrint(interfecio.value);
        }
      });
    });
    _firestore
        .collection('Ext_data')
        .doc('InterfecioAvailable')
        .get()
        .then((value) {
      setState(() {
        if (value.exists) {
          isInterficioAvailable.value = value.data()?["isAvailable"];
        } else {
          // debugPrint(interfecio.value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // String EventName = db
    getuser();
    // List<ComingItem> comingItems = Provider.of<List<ComingItem>>(context);
    Users? users;
    if (Users.us != null) {
      setState(() {
        users = Users.us;
        // print(Users.us.email);
      });
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 6.5.h,
                width: 90.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(17, 70, 105, 0.798),
                        Color.fromRGBO(30, 72, 85, 0.778),
                        Color.fromRGBO(2, 84, 114, 0.88),
                        Color.fromRGBO(29, 95, 117, 0.865),
                        Color.fromRGBO(30, 71, 83, 0.778),
                        Color.fromRGBO(13, 55, 85, 1)
                      ],
                    ),
                    border:
                        Border.all(color: Color.fromRGBO(31, 49, 71, 0.318)),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sigmaX = 5;
                            sigmaY = 5;
                            settingIcon = menuBarIconsSelected[0];
                            personIcon = menuBarIconsUnSelected[1];
                            consoleIcon = menuBarIconsUnSelected[2];
                          });
                          showBottomSheet(
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: Colors.transparent,
                                  height: 100.h,
                                  width: 100.w,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent),
                                      )),
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Color.fromRGBO(
                                                    2, 84, 114, 0.88),
                                                Color.fromRGBO(
                                                    29, 95, 117, 0.865),
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 90.w,
                                          child: OutlineGradientButton(
                                            strokeWidth: 2,
                                            radius: Radius.circular(10),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Colors.grey.shade600,
                                                Colors.grey.shade600,
                                                Colors.grey.shade600,
                                                Color.fromARGB(
                                                    122, 251, 70, 10),
                                                Color.fromARGB(
                                                    122, 251, 70, 10),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.h),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 8.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child:
                                                              (users?.photoURL !=
                                                                      null)
                                                                  ? Image
                                                                      .network(
                                                                      users!
                                                                          .photoURL!,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/profile1.png',
                                                                    ),
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              (users?.name !=
                                                                      null)
                                                                  ? "${users?.name}"
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Staat',
                                                                  fontSize: 3.h,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      1.2),
                                                            ),
                                                            SizedBox(
                                                              height: 1,
                                                            ),
                                                            Text(
                                                              (users?.email !=
                                                                      null)
                                                                  ? "${users?.email}"
                                                                  : "",
                                                              style: TextStyle(
                                                                  letterSpacing:
                                                                      1.2,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      8.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5.w),
                                                  child: Divider(
                                                    thickness: 1.5,
                                                    color: Colors.grey.shade400,
                                                    height: 1.h,
                                                  ),
                                                ),
                                                Container(
                                                  height: 25.h,
                                                  width: 90.w,
                                                  child: Scrollbar(
                                                      thickness: 2.w,
                                                      radius:
                                                          Radius.circular(15),
                                                      thumbVisibility: true,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            MenuItems(
                                                              leadingImage:
                                                                  'assets/timer.png',
                                                              itemName:
                                                                  'TimeLine',
                                                              routeName:
                                                                  '/timeline',
                                                            ),
                                                            MenuItems(
                                                              leadingImage:
                                                                  'assets/AboutUs.png',
                                                              itemName:
                                                                  'About Us',
                                                              routeName:
                                                                  '/about',
                                                            ),
                                                            MenuItems(
                                                              leadingImage:
                                                                  'assets/sponsor.png',
                                                              itemName:
                                                                  'Sponsors',
                                                              routeName:
                                                                  '/sponsor',
                                                            ),
                                                            MenuItems(
                                                              leadingImage:
                                                                  'assets/contributors.png',
                                                              itemName:
                                                                  'Contributors',
                                                              routeName:
                                                                  '/contributor',
                                                            ),
                                                            MenuItems(
                                                              leadingImage:
                                                                  'assets/contactUsIcon.png',
                                                              itemName:
                                                                  'Contact Us',
                                                              routeName:
                                                                  '/contact',
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                                MaterialButton(
                                                  child: Icon(
                                                    Icons.expand_more,
                                                    color: Colors.white,
                                                    size: 25.sp,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      sigmaX = 0;
                                                      sigmaY = 0;
                                                      settingIcon =
                                                          menuBarIconsUnSelected[
                                                              0];
                                                      personIcon =
                                                          menuBarIconsUnSelected[
                                                              1];
                                                      consoleIcon =
                                                          menuBarIconsUnSelected[
                                                              2];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Image.asset(
                          settingIcon,
                          height: 4.h,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sigmaX = 5;
                            sigmaY = 5;
                            personIcon = menuBarIconsSelected[1];
                            settingIcon = menuBarIconsUnSelected[0];
                            consoleIcon = menuBarIconsUnSelected[2];

                            showBottomSheet(
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: Colors.transparent,
                                    height: 100.h,
                                    width: 100.w,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                        )),
                                        Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      2, 84, 114, 0.88),
                                                  Color.fromRGBO(
                                                      29, 95, 117, 0.865),
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 90.w,
                                            child: OutlineGradientButton(
                                              strokeWidth: 2,
                                              radius: Radius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.grey.shade600,
                                                  Colors.grey.shade600,
                                                  Colors.grey.shade600,
                                                  Color.fromARGB(
                                                      122, 251, 70, 10),
                                                  Color.fromARGB(
                                                      122, 251, 70, 10),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.h),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 8.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: (users
                                                                        ?.photoURL !=
                                                                    null)
                                                                ? Image.network(
                                                                    users!
                                                                        .photoURL!,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/profile1.png'),
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                (users?.name !=
                                                                        null)
                                                                    ? "${users?.name}"
                                                                    : "",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Staat',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        3.h,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1.2),
                                                              ),
                                                              SizedBox(
                                                                height: 1,
                                                              ),
                                                              Text(
                                                                (users?.email !=
                                                                        null)
                                                                    ? "${users?.email}"
                                                                    : "",
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                        1.2,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Divider(
                                                      thickness: 1.5,
                                                      color:
                                                          Colors.grey.shade400,
                                                      height: 1.h,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25.h,
                                                    width: 90.w,
                                                    child: Scrollbar(
                                                        thickness: 2.w,
                                                        radius:
                                                            Radius.circular(15),
                                                        thumbVisibility: true,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              MenuItems(
                                                                leadingImage:
                                                                    'assets/eurekoin.png',
                                                                itemName:
                                                                    'Eurekoin',
                                                                routeName:
                                                                    '/eurekoin',
                                                              ),
                                                              MenuItems(
                                                                leadingImage:
                                                                    Icons
                                                                        .logout,
                                                                itemName:
                                                                    'Log Out',
                                                                routeName:
                                                                    '/logout',
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  MaterialButton(
                                                    child: Icon(
                                                      Icons.expand_more,
                                                      color: Colors.white,
                                                      size: 25.sp,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        sigmaX = 0;
                                                        sigmaY = 0;
                                                        settingIcon =
                                                            menuBarIconsUnSelected[
                                                                0];
                                                        personIcon =
                                                            menuBarIconsUnSelected[
                                                                1];
                                                        consoleIcon =
                                                            menuBarIconsUnSelected[
                                                                2];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                });
                          });
                        },
                        child: Image.asset(
                          personIcon,
                          height: 4.h,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sigmaX = 5;
                            sigmaY = 5;
                            consoleIcon = menuBarIconsSelected[2];
                            settingIcon = menuBarIconsUnSelected[0];
                            personIcon = menuBarIconsUnSelected[1];

                            showBottomSheet(
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: Colors.transparent,
                                    height: 100.h,
                                    width: 100.w,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                        )),
                                        Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                                gradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      2, 84, 114, 0.88),
                                                  Color.fromRGBO(
                                                      29, 95, 117, 0.865),
                                                ]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            width: 90.w,
                                            child: OutlineGradientButton(
                                              strokeWidth: 2,
                                              radius: Radius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.grey.shade600,
                                                  Colors.grey.shade600,
                                                  Colors.grey.shade600,
                                                  Color.fromARGB(
                                                      122, 251, 70, 10),
                                                  Color.fromARGB(
                                                      122, 251, 70, 10),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4.h),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: 8.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: (users
                                                                        ?.photoURL !=
                                                                    null)
                                                                ? Image.network(
                                                                    users!
                                                                        .photoURL!,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/profile1.png'),
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                (users?.name !=
                                                                        null)
                                                                    ? "${users!.name}"
                                                                    : "",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Staat',
                                                                    fontSize:
                                                                        3.h,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1.2),
                                                              ),
                                                              SizedBox(
                                                                height: 1,
                                                              ),
                                                              Text(
                                                                (users?.email !=
                                                                        null)
                                                                    ? "${users!.email}"
                                                                    : "",
                                                                style: TextStyle(
                                                                    letterSpacing:
                                                                        1.2,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Divider(
                                                      thickness: 1.5,
                                                      color:
                                                          Colors.grey.shade400,
                                                      height: 1.h,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25.h,
                                                    width: 90.w,
                                                    child: Scrollbar(
                                                        thickness: 2.w,
                                                        radius:
                                                            Radius.circular(15),
                                                        thumbVisibility: true,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              (isInterficioAvailable
                                                                      .value)
                                                                  ? MenuItems(
                                                                      leadingImage:
                                                                          'assets/journo.png',
                                                                      itemName:
                                                                          'Interfecio',
                                                                      // JDTitle,
                                                                      routeName: (!interfecio
                                                                              .value)
                                                                          ? '/journo'
                                                                          : '/coming',
                                                                    )
                                                                  : SizedBox(),
                                                              // MenuItems(
                                                              //   leadingImage:
                                                              //       'assets/game.png',
                                                              //   itemName:
                                                              //       'Games',
                                                              //   routeName:
                                                              //       '/game',
                                                              // ),
                                                              MenuItems(
                                                                leadingImage:
                                                                    'assets/prelims.png',
                                                                itemName:
                                                                    'Prelims',
                                                                routeName: (prelims
                                                                        .value)
                                                                    ? '/prelims'
                                                                    : '/coming',
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  MaterialButton(
                                                    child: Icon(
                                                      Icons.expand_more,
                                                      color: Colors.white,
                                                      size: 25.sp,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        sigmaX = 0;
                                                        sigmaY = 0;
                                                        settingIcon =
                                                            menuBarIconsUnSelected[
                                                                0];
                                                        personIcon =
                                                            menuBarIconsUnSelected[
                                                                1];
                                                        consoleIcon =
                                                            menuBarIconsUnSelected[
                                                                2];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                });
                          });
                        },
                        child: Image.asset(
                          consoleIcon,
                          height: 4.h,
                        ),
                      ),
                    ]),
              ))),
    );
  }
}
