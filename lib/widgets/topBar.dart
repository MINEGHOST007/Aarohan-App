import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:sizer/sizer.dart';

class topBar extends StatefulWidget {
  final String? pageName;

  const topBar({
    Key? key,
    this.pageName,
  }) : super(key: key);

  @override
  State<topBar> createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 3.h,
        horizontal: 2.5.w,
      ),
      child: OutlineGradientButton(
        padding: EdgeInsets.all(1.5),
        corners: Corners(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 251, 71, 10),
            Color.fromARGB(124, 59, 58, 58),
          ],
        ),
        strokeWidth: 2,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            // color: Color.fromRGBO(25, 102, 154, 0.5),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(223, 47, 117, 138),
                Color.fromARGB(255, 4, 29, 37),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            height: 8.h,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        // padding: EdgeInsets.only(
                        //   bottom: 1.h,
                        // ),
                        child: Text(
                          widget.pageName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Bayon',
                            color: Colors.blue[200],
                            fontSize: 4.h,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (widget.pageName == 'Transfer') {
                      Navigator.popAndPushNamed(context, '/leaderboard');
                    } else if (widget.pageName == 'Eurekoins') {
                      Navigator.popAndPushNamed(context, '/dashboard');
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
