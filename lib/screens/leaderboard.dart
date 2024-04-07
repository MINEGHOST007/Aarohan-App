import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/models/user.dart';
import 'package:aarohan_app/resources/eurekoin.dart';
import 'package:aarohan_app/widgets/redeem.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController editingController = TextEditingController();

  bool showBottomMenu = false;
  bool showdialog = false;
  int? _coins;
  String? _referralCode;

  // QRViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    // Eurekoin.getAllUsers("s");
    Eurekoin.getUserEurekoin().then((value) {
      setState(() {
        _coins = value;
        print(_coins);
      });
    });
    Eurekoin.getReferralCode().then((value) {
      setState(() {
        _referralCode = value;
      });
    });
    super.initState();
  }

  Future scanQR(BuildContext context) async {
    try {
      ScanResult scanResult = await BarcodeScanner.scan();
      //     Barcode result;
      //  controller.scannedDataStream.listen((event) {
      //    setState(() {
      //      result =event;
      //    });
      //  });

      // options: ScanOptions(
      //   strings: {
      //     'cancel': _cancelController.text,
      //     'flash_on': _flashOnController.text,
      //     'flash_off': _flashOffController.text,
      //   },
      //   restrictFormat: selectedFormats,
      //   useCamera: _selectedCamera,
      //   autoEnableFlash: _autoEnableFlash,
      //   android: AndroidOptions(
      //     aspectTolerance: _aspectTolerance,
      //     useAutoFocus: _useAutoFocus,
      //   ),
      // ),

      String barcodeString = scanResult.rawContent;
      print(barcodeString);

      // editingController.text= barcodeString;
      int value = await Eurekoin.couponEurekoin(barcodeString);
      // result.then((value) {
      print(value);
      if (value == 0) {
        // barcodeString = "Successful!";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Transaction Successful!")));
      } else if (value == 2) {
        // barcodeString = "Invalid Coupon";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Coupon!")));
      } else if (value == 3) {
        // barcodeString = "Already Used";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Coupon already used!")));
      } else if (value == 4) {
        // barcodeString = "Coupon Expired";
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Coupon Expired!")));
      }
      // });
    } on PlatformException catch (e) {
      print(e.stacktrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    Users users = Users.us;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/aarohan-bg-new.jpg"),
                  // colorFilter: new ColorFilter.mode(
                  //     Color.fromARGB(177, 48, 17, 6), BlendMode.srcOver),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      OutlineGradientButton(
                        padding: EdgeInsets.all(2),
                        strokeWidth: 2,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 251, 71, 10),
                          Colors.transparent,
                        ]),
                        corners: Corners(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Container(
                          // margin: EdgeInsets.symmetric(
                          //     vertical: 3.h, horizontal: 2.5.w),
                          alignment: Alignment.bottomCenter,
                          height: 8.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(223, 47, 117, 138),
                                  Color.fromARGB(255, 4, 29, 37),
                                ],
                              )),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 20,
                                      // backgroundImage: AssetImage('assets/back.png'),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: 30.sp,
                                          color: Colors.blue[200],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Text(
                                    "Eurekoins",
                                    style: TextStyle(
                                      fontFamily: 'Bayon',
                                      color: Colors.blue[200],
                                      fontSize: 4.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Dialog(
                                                insetPadding:
                                                    EdgeInsets.all(5.w),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15.0),
                                                  ),
                                                  side: BorderSide(
                                                    style: BorderStyle.solid,
                                                    width: 1.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                    158, 73, 157, 182),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 2.h,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Redeem Eurekoins",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  0.5,
                                                              fontFamily:
                                                                  'Staat',
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: fromCssColor(
                                                                        "#CECECE"),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.sp)),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(1
                                                                              .sp),
                                                                  child:
                                                                      TextField(
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize: 14
                                                                            .sp,
                                                                        letterSpacing:
                                                                            1),
                                                                    controller:
                                                                        editingController,
                                                                    decoration: InputDecoration(
                                                                        contentPadding: EdgeInsets.fromLTRB(
                                                                            4.w,
                                                                            1.h,
                                                                            3.w,
                                                                            1
                                                                                .h),
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                            'Enter Redeem Code',
                                                                        hintStyle: TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                13.sp,
                                                                            fontWeight: FontWeight.w500)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 4.h,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            int status = await Eurekoin
                                                                .couponEurekoin(
                                                                    editingController
                                                                        .text);

                                                            Eurekoin.getUserEurekoin()
                                                                .then((value) {
                                                              setState(() {
                                                                _coins = value;
                                                              });
                                                            });
                                                            if (status == 0) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Redemption Successful!")));
                                                            } else if (status ==
                                                                2) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Invalid Coupon!")));
                                                            } else if (status ==
                                                                3) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Coupon Already Redeemed!")));
                                                            } else if (status ==
                                                                4) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Coupon Expired!")));
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        7.w,
                                                                    vertical:
                                                                        1.h),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width:
                                                                        1.sp),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Text(
                                                              "REDEEM",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Image.asset(
                                                              'assets/horline.png',
                                                              width: 25.w,
                                                            ),
                                                            Text(
                                                              "OR",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Staat',
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Image.asset(
                                                              'assets/horline.png',
                                                              width: 25.w,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Text(
                                                          "Scan a QR Code",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        InkWell(
                                                            onTap: () async {
                                                              await scanQR(
                                                                  context);
                                                              Eurekoin.getUserEurekoin()
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  _coins =
                                                                      value;
                                                                });
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Image.asset(
                                                                'assets/Scanner.png')),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Icon(
                                      Icons.card_giftcard,
                                      color: Colors.blue[200],
                                      size: 25.sp,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      OutlineGradientButton(
                        gradient: LinearGradient(colors: [
                          Colors.transparent,
                          Color.fromARGB(255, 251, 71, 10),
                        ]),
                        padding: EdgeInsets.all(2),
                        corners: Corners(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        strokeWidth: 2,
                        child: ClipRect(
                          child: Container(
                            width: 85.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                // color: Colors.red),
                                color: Color.fromARGB(209, 73, 157, 182)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 1.7.h, 0, 0),
                                  child: Text(
                                    "${users.name}",
                                    style: TextStyle(
                                      // letterSpacing: 1,
                                      fontFamily: 'Staat',
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 0.7.h, 5.w, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Balance",
                                        style: TextStyle(
                                            letterSpacing: 1.1,
                                            fontFamily: 'Poppins',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      // SizedBox(width: 3.w,),
                                      InkWell(
                                        onTap: () async {
                                          await Share.share(
                                              'Use my referal code $_referralCode to get 25 Eurekoins when you register. \nLink: https://play.google.com/store/apps/details?id=com.app.aarohan.aarohanapp');
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1.h,
                                                  horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                // color: Colors.red.shade100,
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.black,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.share,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              (_referralCode != null)
                                                  ? "$_referralCode"
                                                  : "",
                                              style: TextStyle(
                                                  letterSpacing: 1.1,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4.w, 1.h, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              'assets/eurekoin_logo.jpg',
                                              color: Colors.white,
                                            ),
                                            height: 3.h,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            (_coins != null) ? "$_coins" : "0",
                                            style: TextStyle(
                                                letterSpacing: 1.1,
                                                fontFamily: 'Poppins',
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.w),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.popAndPushNamed(
                                                context, '/transaction');
                                          },
                                          child: Container(
                                            // margin: EdgeInsets.only(left: 3.w),
                                            child: Image.asset(
                                                'assets/Pay icon.png'),
                                            height: height * 0.05,
                                            width: width * 0.06,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(9.w, 2.h, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "Top Eurekoin Owners",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.1,
                                  fontFamily: 'Staat',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Expanded(
                          child: Container(
                        // color: Colors.blue,
                        child: FutureBuilder(
                          future: Eurekoin.fetchLeaderboard(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1.5, sigmaY: 1.5),
                                        child: OutlineGradientButton(
                                          gradient: LinearGradient(colors: [
                                            Colors.transparent,
                                            Color.fromARGB(255, 251, 71, 10),
                                          ]),
                                          padding: EdgeInsets.all(2),
                                          corners: Corners(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                          strokeWidth: 2,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                5.w, 1.h, 2.w, 1.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color.fromARGB(
                                                  204, 73, 157, 182),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${index + 1}.",
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        '${snapshot.data[index]['imageURL']}',
                                                      ),
                                                      radius: 15.sp,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Container(
                                                      width: 45.w,
                                                      // color: Colors.red,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data[index]['username']}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/eurekoin_logo.jpg',
                                                        color: Colors.white,
                                                        height: 4.h,
                                                      ),
                                                      SizedBox(width: 2.w),
                                                      Text(
                                                        "${snapshot.data[index]['coins']}",
                                                        style: TextStyle(
                                                          letterSpacing: 0.5,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            else
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          },
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
