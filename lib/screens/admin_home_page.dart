import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/manage_actor_task.dart';
import 'package:flutter_task_planner_app/screens/viewact.dart';
import 'package:flutter_task_planner_app/widgets/active_project_card.dart';
import 'menu.dart';
import 'package:flutter_task_planner_app/bloc/getuserinfo_bloc.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_task_planner_app/widgets/task_column.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget{
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
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
                                          "Administration",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  subheading('Management Tasks'),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: <Widget>[
                                      ActiveProjectsCard(
                                        icon: Icons.person_add,
                                        cardColor: LightColors.kGreen,
                                        loadingPercent: 0.25,
                                        title: 'Actor',
                                        onTap: (){
                                          print("actor");
                                          String title = "Actor";
                                          var screen = ManageActorTaskPage();
                                          onManageClicked(title,screen);
                                        },
                                      ),
                                      SizedBox(width: 20.0),
                                      ActiveProjectsCard(
                                        icon: Icons.camera_roll,
                                        cardColor: LightColors.kRed,
                                        loadingPercent: 0.6,
                                        title: 'Scene',
                                        onTap: (){
                                          print("Scene Tapped");
                                          String title = "Scene";
                                          //onManageClicked(title);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width/4,
                                      ),
                                      ActiveProjectsCard(
                                        icon: Icons.work,
                                        cardColor: LightColors.kDarkYellow,
                                        loadingPercent: 0.45,
                                        title: 'Tool',
                                        onTap: (){
                                          print("Tool Tapped");
                                          String title = "Tool";
                                          //onManageClicked(title);
                                        },
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width/4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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

  Future<void> onManageClicked(String title, Widget screen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Manage", title);
    print(sharedPreferences.getString("Manage"));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ActorMenuPage(screen: screen,) ));
  }
}
