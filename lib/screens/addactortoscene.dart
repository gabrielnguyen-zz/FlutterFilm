import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/show_actor_scene_bloc.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';

class AddActorToScenePage extends StatefulWidget {
  @override
  _AddActorToScenePageState createState() => _AddActorToScenePageState();
}

class _AddActorToScenePageState extends State<AddActorToScenePage> {
  TextEditingController characterController = TextEditingController();
  TextEditingController actFromController = TextEditingController();
  TextEditingController actToController = TextEditingController();
  List<String> listStatus = ["Waiting", "In Progress", "Done"];
  var bloc = ShowActorSceneBloc();
  String status;
  String dropDownScene;
  String dropDownActor;
  @override
  void initState() {
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
    bloc.showActorScene();
    return Scaffold(
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
                        'Add New Actor To Scene',
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Choose a scene', style: TextStyle(fontSize: 20)),
                      StreamBuilder(
                          stream: bloc.showScenes,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> list = snapshot.data;
                              return DropdownButton<String>(
                                  value: dropDownScene != null ? dropDownScene : null,
                                  items: list.map((e) {
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Row(
                                          children: <Widget>[
                                            Text(e.toString()),
                                          ],
                                        ));
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropDownScene = newValue;
                                    });
                                  });
                            } else {
                              return CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                              );
                            }
                          })
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
                  Row(
                    children: <Widget>[
                      Container(
                          child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Choose an actor',
                              style: TextStyle(fontSize: 20)),
                          StreamBuilder(
                              stream: bloc.showActors,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<String> list = snapshot.data;
                                  return DropdownButton<String>(
                                      value: dropDownActor != null ? dropDownActor : null,
                                      items: list.map((e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: Row(
                                              children: <Widget>[
                                                Text(e.toString()),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropDownActor = newValue;
                                        });
                                      });
                                } else {
                                  return CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.orange),
                                  );
                                }
                              })
                        ],
                      )),
                      SizedBox(width:10),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text('Status', style: TextStyle(fontSize: 20)),
                            DropdownButton(
                                value: status != null ? status : null,
                                items: listStatus.map((e) {
                                  return new DropdownMenuItem(
                                      value: e,
                                      child: Row(
                                        children: <Widget>[
                                          Text(e.toString()),
                                        ],
                                      ));
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    status = newValue;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),

                  MyTextField(
                    label: 'Character for Actor',
                    controller: characterController,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: MyTextField(
                        label: 'Act From',
                        hint: "Ex: 2020-06-03",
                        controller: actFromController,
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'Act To',
                          hint: "Ex: 2020-06-03",
                          controller: actToController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: bloc.result,
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
                print("added");
                FocusScope.of(context).unfocus();
                String character = characterController.text;
                String actFrom = actFromController.text;
                String actTo = actToController.text;
                bloc.addActorToScene(dropDownActor, dropDownScene, character, actFrom, actTo, status);
              },
              child: Container(
                height: 80,
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Add Actor',
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
    );
  }
}
