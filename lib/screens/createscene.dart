import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_task_planner_app/bloc/create_scene_bloc.dart';
import 'package:flutter_task_planner_app/bloc/edit_scene_bloc.dart';
import 'package:flutter_task_planner_app/bloc/edit_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';

class CreateScenePage extends StatefulWidget {
  @override
  _CreateScenePageState createState() => _CreateScenePageState();
}

class _CreateScenePageState extends State<CreateScenePage> {
  var bloc = CreateSceneBloc();

  @override
  Widget build(BuildContext context) {
    TextEditingController sceneNameController = TextEditingController();
    TextEditingController sceneDesController = TextEditingController();
    TextEditingController sceneRecController = TextEditingController();
    TextEditingController sceneLocation = TextEditingController();
    String timeStart = 'Pick Date', timeStop = 'Pick Date';
    double width = MediaQuery.of(context).size.width;
    ChooseFile chooseFile = ChooseFile();

    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );

    return GestureDetector(
       onTap: (){
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if(!focusScopeNode.hasPrimaryFocus){
          focusScopeNode.unfocus();
        }
      },
          child: Scaffold(
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
                          style: TextStyle(
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
                            label: 'Scene Name', controller: sceneNameController),
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
                          keyboard: TextInputType.number,
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
                          child: Column(
                            children: <Widget>[
                              Text('Time Start : '),
                              FlatButton(
                                color: LightColors.kDarkYellow,
                                textColor: Colors.black,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onConfirm: (date) {
                                    setState(() {
                                      timeStart = date.toString().split(" ")[0];
                                    });
                                  });
                                },
                                child: Text(timeStart),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('Time Stop : '),
                              FlatButton(
                                color: LightColors.kDarkYellow,
                                textColor: Colors.black,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onConfirm: (date) {
                                    setState(() {
                                      timeStop = date.toString().split(" ")[0];
                                    });
                                  });
                                },
                                child: Text(timeStop),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      title: Text("Script:"),
                      subtitle:
                          Text('Click to choose file' ?? chooseFile.filename),
                      trailing: Icon(
                        Icons.file_upload,
                        color: LightColors.kDarkYellow,
                      ),
                      onTap: () {
                        FilePicker.getFile().then((file) {
                          var filename =
                              file.path.substring(file.path.lastIndexOf('/') + 1);
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
                          print(filename + " " + extendsion);
                          chooseFile.filename = filename;
                          chooseFile.fileExtension = extendsion;
                          chooseFile.file = file;
                        });
                      },
                    ),
                    StreamBuilder(
                      stream: bloc.createSceneGet,
                      builder: (context, result) {
                        if (result.hasData) {
                          return Text(
                            result.data.toString(),
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  print("Create");
                  String name = sceneNameController.text;
                  String des = sceneDesController.text;
                  int sceneRec = int.parse(sceneRecController.text);
                  String sceneLoc = sceneLocation.text;
                  onCreateSceneClick(name, des, sceneRec, timeStart, timeStop,
                      sceneLoc, false, chooseFile);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Create Scene',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        width: width - 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: <Color>[
                                Color(0xfff46b45),
                                Color(0xffeea849)
                              ]),
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

  void onCreateSceneClick(name, des, rec, timeStart, timeStop, sceneloc,
      bool isDelete, ChooseFile chooseFile) {
    Scene scene = Scene();
    scene.sceneName = name;
    scene.sceneDes = des;
    scene.sceneTimeStart = timeStart;
    scene.scenetTimeStop = timeStop;
    scene.sceneLoc = scene.sceneLoc;
    scene.isDelete = isDelete;
    print(chooseFile.filename);
    bloc.createTool(scene, chooseFile);
  }
}
