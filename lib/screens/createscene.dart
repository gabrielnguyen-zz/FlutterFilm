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
  TextEditingController sceneNameController = TextEditingController();
  TextEditingController sceneDesController = TextEditingController();
  TextEditingController sceneRecController = TextEditingController();
  TextEditingController sceneLocation = TextEditingController();
  String timeStart = 'Pick Date', timeStop = 'Pick Date';

  ChooseFile chooseFile;
  @override
  void initState() {
    // TODO: implement initState
    chooseFile = ChooseFile();
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
                          'Create scene',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700),
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
                              Text(
                                'Time Start : ',
                                style: TextStyle(color: Colors.white),
                              ),
                              FlatButton(
                                color: Color(0xff536976),
                                textColor: Colors.white,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
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
                              Text('Time Stop : ',
                                  style: TextStyle(color: Colors.white)),
                              FlatButton(
                                color: Color(0xff536976),
                                textColor: Colors.white,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
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
                      title: Text(
                        "Script:",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                          chooseFile.filename ?? 'Click to choose file',
                          style: TextStyle(color: Colors.white)),
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
                          print(filename + " " + extendsion);
                          setState(() {
                            chooseFile.filename = filename;
                            chooseFile.fileExtension = extendsion;
                            chooseFile.file = file;
                          });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: StreamBuilder(
                          stream: bloc.createSceneGet,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == 'Logging') {
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
                  print("Create");
                  String name = sceneNameController.text;
                  String des = sceneDesController.text;
                  int sceneRec = int.parse(sceneRecController.text);
                  String sceneLoc = sceneLocation.text;
                  onCreateSceneClick(context, name, des, sceneRec, timeStart,
                      timeStop, sceneLoc, false, chooseFile);
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

  void onCreateSceneClick(context, name, des, rec, timeStart, timeStop,
      sceneloc, bool isDelete, ChooseFile chooseFile) {
    Scene scene = Scene();
    scene.sceneName = name;
    scene.sceneDes = des;
    scene.sceneTimeStart = timeStart;
    scene.scenetTimeStop = timeStop;
    scene.sceneLoc = sceneloc;
    scene.sceneRec = rec;
    scene.isDelete = isDelete;
    print(chooseFile.filename);
    bloc.createTool(context, scene, chooseFile);
  }
}
