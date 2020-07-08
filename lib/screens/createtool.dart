import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/create_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:image_picker/image_picker.dart';

class CreateToolPage extends StatefulWidget {
  @override
  _CreateToolPageState createState() => _CreateToolPageState();
}

class _CreateToolPageState extends State<CreateToolPage> {
  TextEditingController toolNameController = TextEditingController();

  TextEditingController toolDesController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  ChooseFile script;

  var bloc = CreateToolBloc();
  @override
  void initState() {
    // TODO: implement initState
    script = ChooseFile();
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
                          'Create new tool',
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
                            label: 'Tool Name', controller: toolNameController),
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
                    MyTextField(
                      label: 'Quantity',
                      keyboard: TextInputType.number,
                      controller: quantityController,
                    ),
                    SizedBox(width: 40),
                    SizedBox(height: 20),
                    MyTextField(
                      label: 'Description',
                      controller: toolDesController,
                    ),
                    SizedBox(height: 20),
                    buildImg(),
                    SizedBox(height:20),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: StreamBuilder(
                          stream: bloc.createToolGet,
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
                  print("created");
                  FocusScope.of(context).unfocus();
                  onCreateActorClick(context, script);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Create Tool',
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
  buildImg() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              child: Center(
            child: ButtonTheme(
              buttonColor: Colors.blue[800],
              child: RaisedButton(
                child: Text("Add Image",style : TextStyle(color: Colors.white)),
                onPressed: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery)
                    .then((value) {
                  var file = File(value.path);
                  var list = file.toString().split("/");
                  var pic = list[list.length - 1].split("'")[0];
                  this.setState(() {
                    print(pic);
                    script.filename = pic.toString().split(".")[0];
                    script.fileExtension = pic.toString().split(".")[1];
                    script.file = file;
                  });
                });
              }),
            ),
          ),
          ),
          showImage(script)
        ],
      ),
    );
  }
  showImage(ChooseFile script){
    if(script.file!=null){
      return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Container(
                    height: 230,
                    width: 230,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: FileImage(script.file) ,
                    ),
                  ),
                ),
              )
            ],
          );
    }else{
      return Container();
    }
  }

  void onCreateActorClick(context, script) {
    String name = toolNameController.text;
    String des = toolDesController.text;
    int quantity = int.parse(quantityController.text);
    Tool tool = Tool(toolName: name, toolDes: des, quantity: quantity);
    bloc.createTool(context, tool, script);
  }
}
