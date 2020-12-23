import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/edit_tool_bloc.dart';
import 'package:flutter_task_planner_app/bloc/usersetting_bloc.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:image_picker/image_picker.dart';

class EditActorPage extends StatefulWidget {
  final Actor actor;
  EditActorPage(this.actor);

  @override
  _EditActorPageState createState() => _EditActorPageState();
}

class _EditActorPageState extends State<EditActorPage> {
  
  TextEditingController actorNameController;
  TextEditingController actorDesController;
  UserSettingBloc bloc = UserSettingBloc();
  @override
  void initState() {
    // TODO: implement initState
    actorNameController = TextEditingController(text: widget.actor.actorName);
    actorDesController = TextEditingController(text: widget.actor.actorDes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopContainer(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                width: width,
                child: Column(
                  children: <Widget>[
                    MyBackButton(),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Edit actor',
                          style: TextStyle(color: Colors.white,
                              fontSize: 30.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyTextField(
                            label: 'Actor Name', controller: actorNameController),
                      ],
                    ))
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    MyTextField(
                      label: 'Description',
                      controller: actorDesController,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  print("Save");
                  FocusScope.of(context).unfocus();
                  String name = actorNameController.text;
                  String des = actorDesController.text;
                 onEditActorClick(name, des, false, widget.actor);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Save Actor',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        width: width - 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void onEditActorClick(
      name, des, bool isDelete, Actor actor) {
    actor.actorName = name;
    actor.actorDes = des;
    actor.isDelete = isDelete;
    bloc.updateUser(context, actor);
  }
}
