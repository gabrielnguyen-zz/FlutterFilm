import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/edit_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:image_picker/image_picker.dart';

class EditToolPage extends StatefulWidget {
  final Tool tool;
  EditToolPage(this.tool);

  @override
  _EditToolPageState createState() => _EditToolPageState();
}

class _EditToolPageState extends State<EditToolPage> {
  var bloc = EditToolBloc();
  TextEditingController toolNameController;
  TextEditingController toolDesController;
  TextEditingController quantityController;
  String image;
  ChooseFile script;

  @override
  void initState() {
    // TODO: implement initState
    toolNameController = TextEditingController(text: widget.tool.toolName);
    toolDesController = TextEditingController(text: widget.tool.toolDes);
    quantityController =
        TextEditingController(text: widget.tool.quantity.toString());
    script = ChooseFile();
    image = widget.tool.image;
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
                          'Edit tool',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: MyTextField(
                          label: 'Quantity',
                          keyboard: TextInputType.number,
                          controller: quantityController,
                        )),
                        SizedBox(width: 40),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      label: 'Description',
                      controller: toolDesController,
                    ),
                    SizedBox(height: 20),
                    buildImg(image),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: StreamBuilder(
                          stream: bloc.editToolGet,
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
                  FocusScope.of(context).unfocus();
                  String name = toolNameController.text;
                  String des = toolDesController.text;
                  int quantity = int.parse(quantityController.text);
                  print("script : " + script.filename);
                  print("image :" + image);
                  onCreateActorClick(
                      name, des, quantity, false, widget.tool, script,image);
                },
                child: Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Save Tool',
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
                  String name = toolNameController.text;
                  String des = toolDesController.text;
                  int quantity = int.parse(quantityController.text);
                  onCreateActorClick(
                      name, des, quantity, true, widget.tool, script,image);
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
buildImg(image) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              child: Center(
            child: ButtonTheme(
              buttonColor: Colors.blue[800],
              child: RaisedButton(
                child: Text("Edit Image",style : TextStyle(color: Colors.white)),
                onPressed: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery)
                    .then((value) {
                  var file = File(value.path);
                  var list = file.toString().split("/");
                  var pic = list[list.length - 1].split("'")[0];
                  this.setState(() {
                    print(pic);
                    image = null;
                    print(image);
                    script.filename = pic.toString().split(".")[0];
                    script.fileExtension = pic.toString().split(".")[1];
                    script.file = file;
                  });
                });
              }),
            ),
          ),
          ),
          showImage(image,script)
        ],
      ),
    );
  }
  showImage(image,ChooseFile script){
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
    }else if (image!=null){
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
                      backgroundImage: NetworkImage(image) ,
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
  void onCreateActorClick(
      name, des, quantity, bool isDelete, Tool tool, script,image) {
    tool.toolName = name;
    tool.toolDes = des;
    tool.isDelete = isDelete;
    tool.quantity = quantity;
    bloc.editTool(context,tool, script, image);
  }
}
