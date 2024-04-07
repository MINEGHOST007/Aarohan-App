import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/models/user.dart';
import 'package:aarohan_app/models/event.dart';
import 'package:aarohan_app/sliver_components/SABT.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Event_Detail extends StatefulWidget {
  @override
  _Event_DetailState createState() => _Event_DetailState();
}

GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

bool checkCalendar(String eventName, List calendar) {
  for (var i = 0; i < calendar.length; i++) {
    if (calendar[i].toString() == eventName) return false;
  }
  return true;
}

class _Event_DetailState extends State<Event_Detail> {
  Map data = {};
  bool showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    Users users = Users.us;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    data = ModalRoute.of(context)?.settings.arguments as Map;
    EventItem eventItem = data['eventItem'];
    bool vis = checkCalendar(eventItem.title!, users.calendar!);
    List<String> textsplit = eventItem.contact!.split('-');
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
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.amber,
                          // height: 100.h,
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                leading: Container(
                                  padding: EdgeInsets.fromLTRB(5.w, 2.h, 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color.fromARGB(
                                            216, 100, 180, 246),
                                      ),
                                      // margin: EdgeInsets.only(top: 5.h),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                flexibleSpace: OutlineGradientButton(
                                  corners: Corners(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(1),
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 251, 71, 10),
                                    Color.fromARGB(124, 59, 58, 58),
                                  ]),
                                  strokeWidth: 1.5,
                                  child: Container(
                                    // height: 20.h,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(223, 47, 117, 138),
                                          Color.fromARGB(255, 4, 29, 37),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Color.fromRGBO(25, 102, 154, 1),

                                      // border: Border.all(
                                      //   color:
                                      //       Color.fromRGBO(101, 171, 254, 0.32),
                                      //   width: 0.5.w,
                                      // ),
                                    ),
                                    child: Container(
                                      child: FlexibleSpaceBar(
                                        collapseMode: CollapseMode.pin,
                                        title: SABT(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 2.h, 0, 0),
                                                width: 70.w,
                                                // margin: EdgeInsets.only(
                                                //   bottom: 2.h,
                                                // ),
                                                child: Center(
                                                  child: Text(
                                                    eventItem.title!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 1,
                                                      fontFamily: 'Orbitron',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        background: Container(
                                          child: CachedNetworkImage(
                                            imageUrl: eventItem.imageUrl!,
                                            width: 80.w,
                                            fit: BoxFit.cover,
                                            height: 60.h,
                                            errorWidget: (context, url, error) {
                                              print("Could not load content");
                                              return Image.asset(
                                                "assets/placeholder.jpg",
                                                height: 60.h,
                                                width: 80.w,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              "assets/placeholder.jpg",
                                              height: 60.h,
                                              width: 80.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                pinned: true,
                                // floating: true,
                                expandedHeight: 40.h,
                                backgroundColor: Colors.transparent,
                                collapsedHeight: 8.h,
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate([
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 3.h,
                                        right: 4.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () async {},
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 0, 0, 0),
                                              child: Container(
                                                height: 8.h,
                                                width: 43.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color.fromARGB(
                                                          185, 105, 162, 189),
                                                      Color.fromARGB(
                                                          188, 8, 54, 75),
                                                    ])),
                                                child: OutlineGradientButton(
                                                  strokeWidth: 1.5,
                                                  corners: Corners(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          124, 59, 58, 58),
                                                      Color.fromARGB(
                                                          255, 251, 71, 10),
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 23.5.sp,
                                                            color:
                                                                Colors.white),
                                                        Text(eventItem.date!,
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontFamily:
                                                                    'Staat',
                                                                letterSpacing:
                                                                    1.1,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {},
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 0, 0, 0),
                                              child: Container(
                                                height: 8.h,
                                                width: 43.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color.fromARGB(
                                                          185, 105, 162, 189),
                                                      Color.fromARGB(
                                                          188, 8, 54, 75),
                                                    ])),
                                                child: OutlineGradientButton(
                                                  strokeWidth: 1.5,
                                                  corners: Corners(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          124, 59, 58, 58),
                                                      Color.fromARGB(
                                                          255, 251, 71, 10),
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .workspaces_filled,
                                                            size: 23.5.sp,
                                                            color:
                                                                Colors.white),
                                                        Text(
                                                            eventItem.category!,
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontFamily:
                                                                    'Staat',
                                                                letterSpacing:
                                                                    1.1,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 1.7.h,
                                        right: 4.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              UrlLauncher.launch(
                                                  "tel://${textsplit[0]}");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 0, 0, 0),
                                              child: Container(
                                                height: 8.h,
                                                width: 43.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color.fromARGB(
                                                          185, 105, 162, 189),
                                                      Color.fromARGB(
                                                          188, 8, 54, 75),
                                                    ])),
                                                child: OutlineGradientButton(
                                                  strokeWidth: 1.5,
                                                  corners: Corners(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          124, 59, 58, 58),
                                                      Color.fromARGB(
                                                          255, 251, 71, 10),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        size: 23.5.sp,
                                                        color: Colors.white,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(textsplit[0],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontFamily:
                                                                        'Staat',
                                                                    letterSpacing:
                                                                        1.1,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                            // Text(textsplit[1],
                                                            //     style: TextStyle(
                                                            //         fontSize:
                                                            //             14.sp,
                                                            //         fontFamily:
                                                            //             'Staat',
                                                            //         letterSpacing:
                                                            //             1.1,
                                                            //         color: Colors
                                                            //             .white,
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .w400)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {},
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4.w, 0, 0, 0),
                                              child: Container(
                                                height: 8.h,
                                                width: 43.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    gradient:
                                                        LinearGradient(colors: [
                                                      Color.fromARGB(
                                                          185, 105, 162, 189),
                                                      Color.fromARGB(
                                                          188, 8, 54, 75),
                                                    ])),
                                                child: OutlineGradientButton(
                                                  strokeWidth: 1.5,
                                                  corners: Corners(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          124, 59, 58, 58),
                                                      Color.fromARGB(
                                                          255, 251, 71, 10),
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      UrlLauncher.launch(
                                                          "${eventItem.link}");
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(Icons.open_in_new,
                                                            size: 23.5.sp,
                                                            color:
                                                                Colors.white),
                                                        Text('Go to Event',
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontFamily:
                                                                    'Staat',
                                                                letterSpacing:
                                                                    1.1,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5.w, 3.h, 2.w, 0),
                                      child: Text(eventItem.title!,
                                          style: TextStyle(
                                              fontSize: 21.5.sp,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 1.1,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          5.w, 3.h, 7.w, 2.h),
                                      child: Text(eventItem.body!,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 1.1,
                                              fontWeight: FontWeight.w200)),
                                    )
                                  ],
                                ),
                              ]))
                            ],
                          ),
                        ),
                      ),
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
