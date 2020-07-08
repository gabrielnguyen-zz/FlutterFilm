import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_task_planner_app/bloc/show_tool_scene_bloc.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';

class AddToolToScenePage extends StatefulWidget {
  @override
  _AddToolToScenePageState createState() => _AddToolToScenePageState();
}

class _AddToolToScenePageState extends State<AddToolToScenePage> {
  var bloc = ShowToolSceneBloc();
  TextEditingController quantityController = TextEditingController();
  String dropDownScene;
  String dropDownTool;
  String toolFrom = 'Pick Date', toolTo = 'Pick Date';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.showToolScene();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            backgroundColor: Color.fromRGBO(20, 9, 53, 1),
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
                          style: TextStyle(color: Colors.white,
                              fontSize: 26.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Choose a scene', style: TextStyle(fontSize: 20,color: Colors.white)),
                        StreamBuilder(
                            stream: bloc.showScenes,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<String> list = snapshot.data;
                                return DropdownButton<String>(
                                    dropdownColor: Color(0xff536976),
                                    value: dropDownScene != null
                                        ? dropDownScene
                                        : null,
                                    items: list.map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Row(
                                            children: <Widget>[
                                              Text(e.toString(),style: TextStyle(color:Colors.white),),
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
                                      Colors.white),
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
                    Container(
                        child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Choose a Tool', style: TextStyle(fontSize: 20,color: Colors.white)),
                        StreamBuilder(
                            stream: bloc.showTools,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<String> list = snapshot.data;
                                return DropdownButton<String>(
                                  dropdownColor: Color.fromRGBO(20, 9, 53, 1),
                                    value: dropDownTool != null
                                        ? dropDownTool
                                        : null,
                                    items: list.map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: Row(
                                            children: <Widget>[
                                              Text(e.toString(),style: TextStyle(color: Colors.white),),
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropDownTool = newValue;
                                      });
                                    });
                              } else {
                                return CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                );
                              }
                            })
                      ],
                    )),
                    SizedBox(width: 10),
                    MyTextField(
                      label: 'Quantity',
                      keyboard: TextInputType.number,
                      controller: quantityController,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Expanded(
                        //     child: MyTextField(
                        //   label: 'Act From',
                        //   hint: "Ex: 2020-06-03",
                        //   controller: actFromController,
                        // )),
                        // SizedBox(width: 40),
                        // Expanded(
                        //   child: MyTextField(
                        //     label: 'Act To',
                        //     hint: "Ex: 2020-06-03",
                        //     controller: actToController,
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('Use Tool From : ', style: TextStyle(color:Colors.white),),
                              FlatButton(
                                color: Color(0xff536976),
                                textColor: Colors.black,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onConfirm: (date) {
                                    setState(() {
                                      toolFrom = date.toString().split(" ")[0];
                                    });
                                  });
                                },
                                child: Text(toolFrom,style: TextStyle(color:Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text('Use Tool To : ',style: TextStyle(color:Colors.white)),
                              FlatButton(
                                color: Color(0xff536976),
                                textColor: Colors.black,
                                onPressed: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onConfirm: (date) {
                                    setState(() {
                                      toolTo = date.toString().split(" ")[0];
                                    });
                                  });
                                },
                                child: Text(toolTo,style: TextStyle(color:Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    
                  ],
                ),
              )),
              GestureDetector(
                onTap: () {
                  print("added");
                  FocusScope.of(context).unfocus();
                  String quantity = quantityController.text;
                  bloc.addToolToScene(context,dropDownTool, dropDownScene, quantity, toolFrom, toolTo);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Add Tool',
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
}
