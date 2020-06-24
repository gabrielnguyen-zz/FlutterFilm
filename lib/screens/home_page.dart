import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/viewact.dart';
import 'menu.dart';
import 'package:flutter_task_planner_app/bloc/getuserinfo_bloc.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_task_planner_app/widgets/task_column.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnimationController animationController;

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

  GetUserInfoBloc bloc = GetUserInfoBloc();
  @override
  Widget build(BuildContext context) {
    bloc.getAllStatusScene();
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: bloc.userInfo,
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
                                          snapshot.data.actorName,
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
                                          snapshot.data.email,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      subheading('My Acting'),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  TaskColumn(
                                    icon: Icons.blur_circular,
                                    iconBackgroundColor:
                                        LightColors.kDarkYellow,
                                    title: 'Incoming',
                                    subtitle: snapshot.data.waiting.toString() +
                                        ' act are coming.',
                                    onTap: () {
                                      String title = "Waiting";

                                      print("tapped");
                                      onTaskClicked(title);
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TaskColumn(
                                    icon: Icons.alarm,
                                    iconBackgroundColor: LightColors.kRed,
                                    title: 'In Progress',
                                    subtitle:
                                        snapshot.data.inProgress.toString() +
                                            ' are current acting now.',
                                    onTap: () {
                                      String title = "In Progress";

                                      print("tapped");
                                      onTaskClicked(title);
                                    },
                                  ),
                                  SizedBox(height: 15.0),
                                  TaskColumn(
                                    icon: Icons.check_circle_outline,
                                    iconBackgroundColor: LightColors.kBlue,
                                    title: 'Done',
                                    subtitle: snapshot.data.done.toString() +
                                        ' act had finished',
                                    onTap: () {
                                      String title = "Done";
                                      print("tapped");
                                      onTaskClicked(title);
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
                    ),
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
          );
        });
  }

  Future<void> onTaskClicked(String title) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Act", title);
    print(sharedPreferences.getString("Act"));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ActorMenuPage(screen: ViewActPage(),) ));
  }
}
