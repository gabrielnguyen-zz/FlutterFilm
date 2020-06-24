import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/viewact_bloc.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/act_column.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_task_planner_app/widgets/top_container.dart';

class ViewActPage extends StatefulWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  _ViewActState createState() => _ViewActState();
}

class _ViewActState extends State<ViewActPage> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  ViewActBloc bloc = ViewActBloc();
  @override
  Widget build(BuildContext context) {
    print("alo");
    bloc.viewActBasedOnTitle();
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: bloc.viewAct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: LightColors.kLightYellow,
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    TopContainer(
                      height: 200,
                      width: width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CircularPercentIndicator(
                                    radius: 90.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.75,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: LightColors.kRed,
                                    backgroundColor: LightColors.kDarkYellow,
                                    center: CircleAvatar(
                                      backgroundColor: LightColors.kBlue,
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar.png',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          snapshot.data[0].actorName,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          snapshot.data[0].email,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    subheading('My Acting'),
                                  ],
                                ),
                                SizedBox(height: 15.0),
                                for (var data in snapshot.data) 
                                  ActColumn(
                                    title: "Character : " + data.character,
                                    subtitle: "From " +
                                        data.actFrom +
                                        " To " +
                                        data.actTo +
                                        "\nOn Scene No." +
                                        data.sceneId.toString(),
                                    onTap: () {
                                      print("tapped");
                                    },
                                  ),
                              ],
                            ),
                          ),
                          // Container(
                          //   color: Colors.transparent,
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 20.0, vertical: 10.0),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: <Widget>[
                          //       subheading('Active Projects'),
                          //       SizedBox(height: 5.0),
                          //       Row(
                          //         children: <Widget>[
                          //           ActiveProjectsCard(
                          //             cardColor: LightColors.kGreen,
                          //             loadingPercent: 0.25,
                          //             title: 'Medical App',
                          //             subtitle: '9 hours progress',
                          //           ),
                          //           SizedBox(width: 20.0),
                          //           ActiveProjectsCard(
                          //             cardColor: LightColors.kRed,
                          //             loadingPercent: 0.6,
                          //             title: 'Making History Notes',
                          //             subtitle: '20 hours progress',
                          //           ),
                          //         ],
                          //       ),
                          //       Row(
                          //         children: <Widget>[
                          //           ActiveProjectsCard(
                          //             cardColor: LightColors.kDarkYellow,
                          //             loadingPercent: 0.45,
                          //             title: 'Sports App',
                          //             subtitle: '5 hours progress',
                          //           ),
                          //           SizedBox(width: 20.0),
                          //           ActiveProjectsCard(
                          //             cardColor: LightColors.kBlue,
                          //             loadingPercent: 0.9,
                          //             title: 'Online Flutter Course',
                          //             subtitle: '23 hours progress',
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            print("loading");
            return CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
            );
          }
        });
  }
}