import 'dart:developer';

import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/models/schedule.dart';
import 'package:aarohan_app/services/sort_timeline.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/widgets/timeline_list.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Map<String, List> M = {};
  bool showBottomMenu = false;
  String day = "8th";
  int x = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    List<DayItem> dayItems = Provider.of<List<DayItem>>(context);
    Sort_Events sort = Sort_Events();
    setState(() {
      if (x == 0 && dayItems.length != 0) {
        M = sort.func(dayItems[0].events);
        x++;
        print(dayItems);
      }
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/aarohan-bg-new.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomGestureDetector(
                axis: CustomGestureDetector.AXIS_Y,
                velocity: threshold,
                onSwipeUp: () {
                  this.setState(() {
                    showBottomMenu = true;
                  });
                },
                onSwipeDown: () {
                  this.setState(() {
                    showBottomMenu = false;
                  });
                },
                onTap: () {},
                child: Column(
                  children: [
                    topBar(
                      pageName: "Timeline",
                    ),
                    Container(
                      // margin:
                      //     EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      height: 7.h,
                      width: 95.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // InkWell(
                          //   radius: 20.0,
                          //   onTap: () {
                          //     setState(() {
                          //       day = "9th";
                          //       M = {};
                          //       M = sort.func(dayItems[4].events);
                          //       print(M);
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 8.h,
                          //     width: 23.w,
                          //     decoration: BoxDecoration(
                          //       color: (day == "9th")
                          //           ? Color.fromRGBO(252, 252, 252, 0.281)
                          //           : Colors.transparent,
                          //       borderRadius: BorderRadius.circular(20.0),
                          //     ),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           "9",
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontFamily: 'Staat',
                          //             fontSize: 18.sp,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //         SizedBox(height: 3.5),
                          //         Visibility(
                          //           visible: (day == "9th"),
                          //           child: Container(
                          //             height: 5,
                          //             width: 5,
                          //             decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               shape: BoxShape.circle,
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          InkWell(
                            radius: 20.0,
                            onTap: () {
                              setState(() {
                                day = "8th";
                                M = {};
                                M = sort.func(dayItems[0].events);
                                print(M);
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 23.w,
                              decoration: BoxDecoration(
                                color: (day == "8th")
                                    ? Color.fromRGBO(252, 252, 252, 0.281)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "8",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Staat',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (day == "8th"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            radius: 20.0,
                            onTap: () {
                              print(dayItems[1].events);
                              setState(() {
                                day = "9th";
                                M = {};
                                M = sort.func(dayItems[1].events);
                                print(M);
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 23.w,
                              decoration: BoxDecoration(
                                color: (day == "9th")
                                    ? Color.fromRGBO(252, 252, 252, 0.281)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "9",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Staat',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (day == "9th"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            radius: 20.0,
                            onTap: () {
                              setState(() {
                                day = "10th";
                                M = {};
                                M = sort.func(dayItems[2].events);
                                print(M);
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 23.w,
                              decoration: BoxDecoration(
                                color: (day == "10th")
                                    ? Color.fromRGBO(252, 252, 252, 0.281)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "10",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Staat',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (day == "10th"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 3,
                      width: 95.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.amber,
                        padding: EdgeInsets.only(top: 3.h),
                        height: 59.h,
                        // color: Colors.red,
                        child: (M.length != 0)
                            ? ListView.builder(
                                itemCount: M.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(8.w, 0, 0, 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle_outlined,
                                              color: Colors.white,
                                              size: 10.sp,
                                            ),
                                            SizedBox(
                                              width: 2.5.w,
                                            ),
                                            Text(
                                              "${M.keys.elementAt(index)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Gugi',
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Timeline_List(
                                            M[M.keys.elementAt(index)]!)
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
