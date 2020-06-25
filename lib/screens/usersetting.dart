import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/getuserinfo_bloc.dart';
import 'package:flutter_task_planner_app/bloc/usersetting_bloc.dart';
import 'package:flutter_task_planner_app/bloc/viewact_bloc.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_task_planner_app/widgets/top_container.dart';

class UserSettingPage extends StatefulWidget {
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
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSettingPage> {
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

  TextEditingController mailController = TextEditingController();
  TextEditingController actorDesController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GetUserInfoBloc bloc = GetUserInfoBloc();
  UserSettingBloc setBloc = UserSettingBloc();
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
                                      subheading('Edit Information'),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  TextField(
                                      controller: actorDesController,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      
                                      decoration: InputDecoration(
                                        labelText: "ACTOR DESCRIPTION",
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 15),
                                      )),
                                  TextField(
                                      controller: mailController,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      
                                      decoration: InputDecoration(
                                        labelText: "MAIL",
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 15),
                                      )),
                                  TextField(
                                      controller: phoneController,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      
                                      decoration: InputDecoration(
                                        labelText: "PHONE",
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        labelStyle: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 15),
                                      )),
                                  RaisedButton(
                                    onPressed: (){
                                      onSaveClicked(snapshot.data);
                                    },
                                    color: LightColors.kDarkYellow,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.topLeft,
                                            colors: <Color>[
                                              Color(0xfff46b45),
                                              Color(0xffeea849)
                                            ]),
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: const Text('Save',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: setBloc.userSet,
                                    builder: (context,result){
                                      if(result.hasData){
                                        return Text(
                                          result.data.toString(),
                                          style: TextStyle(color: Colors.red,fontSize: 20),
                                          );
                                      }
                                      return Text('');
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
          } else {
            print("loading");
            return CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
            );
          }
        });
  }
  void onSaveClicked(Actor actor){
    FocusScope.of(context).unfocus();
    String email = mailController.text;
    String phone = phoneController.text;
    String actorDes = actorDesController.text;
    actor.email = email;
    actor.phone = phone;
    actor.actorDes = actorDes;
    setBloc.updateUser(actor);
  }
}
