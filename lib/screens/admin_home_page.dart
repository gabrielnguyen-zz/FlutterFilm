import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/getuserinfo_bloc.dart';
import 'package:flutter_task_planner_app/screens/addactortoscene.dart';
import 'package:flutter_task_planner_app/screens/addtooltoscene.dart';
import 'package:flutter_task_planner_app/screens/admin_menu.dart';
import 'package:flutter_task_planner_app/screens/manage_actor_task.dart';
import 'package:flutter_task_planner_app/screens/manage_scene_dart.dart';
import 'package:flutter_task_planner_app/screens/manage_tool_dart.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/active_project_card.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  GetUserInfoBloc bloc = GetUserInfoBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.getAllStatusScene();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
         
            return Scaffold(
              backgroundColor: Color.fromRGBO(20, 9, 53, 1),
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
                                  child: StreamBuilder(
                                    stream: bloc.userInfo,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        return Row(
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
                                            backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                                            center: CircleAvatar(
                                              backgroundColor: Color.fromRGBO(149, 161, 203, 1),
                                              radius: 35.0,
                                              backgroundImage: snapshot.data.image !=null ? NetworkImage(snapshot.data.image) : AssetImage(
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
                                                    color: Colors.white,
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
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                      }else{
                                        return CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  );
                                      }
                                      
                                    }
                                  ),
                                )
                              ]
                        
                      ),
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
                                        title: 'Add Actor To Scene',
                                        onTap: (){
                                          //String name = snapshot.data.actorName;
                                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddActorToScenePage()));
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddActorToScenePage()));
                                        },
                                      ),
                                      SizedBox(width: 20.0),
                                      ActiveProjectsCard(
                                        icon: Icons.camera_enhance,
                                        cardColor: LightColors.kRed,
                                        loadingPercent: 0.6,
                                        title: 'Add Tool To Scene',
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => AddToolToScenePage()));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ActiveProjectsCard(
                                        icon: Icons.person,
                                        cardColor: Color(0xFF348F50),
                                        loadingPercent: 0.25,
                                        title: 'Manage Actor',
                                        onTap: (){
                                          var screen = ManageActorTaskPage();
                                          onManageClicked(screen);
                                        },
                                      ),
                                      SizedBox(width: 20.0),
                                      ActiveProjectsCard(
                                        icon: Icons.camera_roll,
                                        cardColor: LightColors.kBlue,
                                        loadingPercent: 0.6,
                                        title: ' Manage Scene',
                                        onTap: (){
                                          var screen = ManageSceneTaskPage();
                                          onManageClicked(screen);
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
                                        title: 'Manage Tool',
                                        onTap: (){
                        
                                          var screen = ManageToolTaskPage();
                                          onManageClicked(screen);
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

  Future<void> onManageClicked( Widget screen) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminMenuPage(screen: screen,) ));
  }
}
