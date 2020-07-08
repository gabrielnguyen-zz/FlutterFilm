import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/edit_scene_bloc.dart';
import 'package:flutter_task_planner_app/bloc/edit_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:image_picker/image_picker.dart';

class EditScenePage extends StatefulWidget {
  final Scene scene;
  EditScenePage(this.scene);

  @override
  _EditScenePageState createState() => _EditScenePageState();
}

class _EditScenePageState extends State<EditScenePage> {
  var bloc = EditSceneBloc();

  TextEditingController sceneNameController;
  TextEditingController sceneDesController;
  TextEditingController sceneRecController;
  TextEditingController sceneTimeStartController;
  TextEditingController sceneTimeStopController;
  TextEditingController sceneLocation;

  ChooseFile chooseFile;

  @override
  void initState() {
    sceneNameController = TextEditingController(text: widget.scene.sceneName);
    sceneDesController = TextEditingController(text: widget.scene.sceneDes);
    sceneRecController =
        TextEditingController(text: widget.scene.sceneRec.toString());
    sceneTimeStartController =
        TextEditingController(text: widget.scene.sceneTimeStart);
    sceneTimeStopController =
        TextEditingController(text: widget.scene.scenetTimeStop);
    sceneLocation = TextEditingController(text: widget.scene.sceneLoc);
    chooseFile = ChooseFile();
    // TODO: implement initState
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
                          'Edit scene',
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
                            label: 'Scene Name',
                            controller: sceneNameController),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: MyTextField(
                          label: 'Scene Rec',
                          controller: sceneRecController,
                        )),
                        SizedBox(width: 40),
                        Expanded(
                          child: MyTextField(
                            label: 'Scene Location',
                            controller: sceneLocation,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      label: 'Description',
                      controller: sceneDesController,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: MyTextField(
                          label: 'Scene Time Start',
                          controller: sceneTimeStartController,
                        )),
                        SizedBox(width: 40),
                        Expanded(
                          child: MyTextField(
                            label: 'Scene Time Stop',
                            controller: sceneTimeStopController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      title: Text("Script:",style: TextStyle(color : Colors.white),),
                      subtitle:
                          Text(chooseFile.filename ?? widget.scene.sceneActors,style: TextStyle(color : Colors.white)),
                      trailing: Icon(
                        Icons.file_upload,
                        color: Colors.white,
                      ),
                      onTap: () {
                        FilePicker.getFile().then((file) {
                          var filename = file.path
                              .substring(file.path.lastIndexOf('/') + 1);
                          var extendsion =
                              filename.substring(filename.lastIndexOf('.') + 1);
                          print(filename + " " + extendsion);
                          if (extendsion != 'pdf' &&
                              extendsion != 'doc' &&
                              extendsion != 'txt' &&
                              extendsion != 'docx') {
                            return Text(
                              "File is not allowed",
                              style: TextStyle(color: Colors.red),
                            );
                          }
                          setState(() {
                            chooseFile.filename = filename;
                            chooseFile.fileExtension = extendsion;
                            chooseFile.file = file;
                            chooseFile.isNew = true;
                          });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: StreamBuilder(
                          stream: bloc.editSceneGet,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == 'Logging') {
                                FocusScope.of(context).requestFocus();
                                return Container(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                  padding: EdgeInsets.all(15),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  print("Save");
                  String name = sceneNameController.text;
                  String des = sceneDesController.text;
                  String timeStart = sceneTimeStartController.text;
                  String timeStop = sceneTimeStopController.text;
                  int sceneRec = int.parse(sceneRecController.text);
                  String sceneLoc = sceneLocation.text;
                  onEditSceneClick(context,name, des, sceneRec, timeStart, timeStop,
                      sceneLoc, false, widget.scene, chooseFile);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Save Scene',
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
              GestureDetector(
                onTap: () {
                  print("Delete");
                  FocusScope.of(context).unfocus();
                  String name = sceneNameController.text;
                  String des = sceneDesController.text;
                  String timeStart = sceneTimeStartController.text;
                  String timeStop = sceneTimeStopController.text;
                  int sceneRec = int.parse(sceneRecController.text);
                  String sceneLoc = sceneLocation.text;
                  onEditSceneClick(context,name, des, sceneRec, timeStart, timeStop,
                      sceneLoc, true, widget.scene, chooseFile);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Delete Tool',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        width: width - 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
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

  void onEditSceneClick(context,name, des, rec, timeStart, timeStop, sceneloc,
      bool isDelete, Scene scene, ChooseFile chooseFile) {
    scene.sceneName = name;
    scene.sceneDes = des;
    scene.sceneTimeStart = timeStart;
    scene.scenetTimeStop = timeStop;
    scene.sceneLoc = scene.sceneLoc;
    scene.isDelete = isDelete;
    print(chooseFile.filename);
    bloc.editScene(context,scene, chooseFile);
  }
}
