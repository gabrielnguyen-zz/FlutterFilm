import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/getuserinfo_bloc.dart';
import 'package:flutter_task_planner_app/bloc/usersetting_bloc.dart';
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
          color: Colors.white,
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
  void initState() {
    // TODO: implement initState
    bloc.getAllStatusScene();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: StreamBuilder(
          stream: bloc.userInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: Color.fromRGBO(3, 9, 23, 1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: LightColors.kRed,
                                      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                                      center: CircleAvatar(
                                        backgroundColor: LightColors.kBlue,
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
                                                  snapshot.data.email,
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
                                        subheading('Edit Information',),
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
                                        keyboardType: TextInputType.number,
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
                                    GestureDetector(
                                      onTap: () {
                                        onSaveClicked(snapshot.data);
                                      },
                                      child: Container(
                                        height: 50,
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.fromLTRB(20, 10, 20, 20),
                                        width: width - 40,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[800],
                                          borderRadius:
                                              BorderRadius.circular(30),
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
          }),
    );
  }

  void onSaveClicked(Actor actor) {
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
