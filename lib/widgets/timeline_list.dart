import 'dart:math';

import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:sizer/sizer.dart';
import 'package:from_css_color/from_css_color.dart';
import 'dart:ui';

class Timeline_List extends StatelessWidget {
  Timeline_List(this.data);
  final List data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(data);
    return ClipRect(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 1..w),
        // color: Colors.white,
        height: 10.h * data.length,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                // SizedBox(
                //   width: 1.w,
                // ),
                Container(
                  child: Image.asset('assets/line.png'),
                  height: 10.h,
                  width: width * 0.01,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  // color: Colors.red,
                  // height: 9.h,
                  child: ClipRRect(
                    borderRadius: (index == data.length - 1)
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(
                              15,
                            ),
                            // bottomRight: Radius.circular(10.sp),
                            // topRight: Radius.circular(10.sp),
                          )
                        : BorderRadius.all(
                            Radius.circular(0),
                          ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: OutlineGradientButton(
                        padding: EdgeInsets.all(0),
                        strokeWidth: 2,
                        corners: (index == data.length - 1)
                            ? Corners(bottomLeft: Radius.circular(15))
                            : Corners(),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Color.fromARGB(255, 163, 90, 58),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: Container(
                          width: width * 0.85,
                          decoration: BoxDecoration(
                              // rgba(120,146,166,255)
                              // color: Colors.red,
                              // borderRadius: BorderRadius.only(
                              //   // topRight: Radius.circular(15),
                              //   bottomLeft: Radius.circular(15),
                              //   // bottomRight: Radius.circular(15),
                              // ),
                              // border: Border(
                              //   top: BorderSide(
                              //     color: Colors.black,
                              //     width: 1,
                              //     style: BorderStyle.solid,
                              //   ),
                              // ),
                              ),
                          height: 10.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(3.w, 1.5.h, 0, 0),
                                child: Text(
                                  "${data[index]}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.fromLTRB(3.w, 0.4.h, 0, 0),
                              //   child: Text(
                              //     "Online",
                              //     style: TextStyle(
                              //       fontFamily: 'Poppins',
                              //       fontSize: 11.sp,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ],  
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
