import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/edit_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/file.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';

class EditToolPage extends StatefulWidget {
  final Tool tool;
  EditToolPage(this.tool);

  @override
  _EditToolPageState createState() => _EditToolPageState();
}

class _EditToolPageState extends State<EditToolPage> {
  var bloc = EditToolBloc();

  @override
  Widget build(BuildContext context) {
    TextEditingController toolNameController =
        TextEditingController(text: widget.tool.toolName);
    TextEditingController toolDesController =
        TextEditingController(text: widget.tool.toolDes);
    TextEditingController quantityController =
        TextEditingController(text: widget.tool.quantity.toString());
        ChooseFile script ;
        
    double width = MediaQuery.of(context).size.width;
    initState(){
      script = ChooseFile();
    }
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
                          'Edit tool',
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
                        // Expanded(
                        //   child: MyTextField(
                        //     label: 'Image',
                        //     controller: ima,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      label: 'Description',
                      controller: toolDesController,
                    ),
                    SizedBox(height: 20),
                    ListTile(
                            
                            title: Text("Tool Image:"),
                            subtitle:
                                Text(widget.tool.image ??  script.filename),
                            trailing: Icon(
                              Icons.file_upload,
                              color: LightColors.kDarkYellow,
                            ),
                            onTap: () {
                              FilePicker.getFile().then((file) {
                                var filename = file.path
                                    .substring(file.path.lastIndexOf('/') + 1);
                                var extendsion = filename
                                    .substring(filename.lastIndexOf('.') + 1);

                                if (extendsion != 'pdf' && extendsion != 'jpg' && extendsion !='png') {
                                  return Text(
                                    'File is not allowed',
                                    style: TextStyle(color: Colors.red),
                                  );
                                }
                                setState(() {
                                  script.filename = filename;
                                  script.fileExtension = extendsion;
                                  script.file = file;
                                });
                              });
                            },
                          ),
                    SizedBox(height: 20),
                    StreamBuilder(
                      stream: bloc.editToolGet,
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
                  print("Save");
                  FocusScope.of(context).unfocus();
                  String name = toolNameController.text;
                  String des = toolDesController.text;
                  int quantity = int.parse(quantityController.text);
                  onCreateActorClick(name,des,quantity,false,widget.tool,script);
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
              GestureDetector(
                onTap: () {
                  print("Delete");
                  FocusScope.of(context).unfocus();
                  String name = toolNameController.text;
                  String des = toolDesController.text;
                  int quantity = int.parse(quantityController.text);
                  onCreateActorClick(name,des,quantity,true,widget.tool,script);
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
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.topLeft,
                              colors: <Color>[
                                Color(0xffff9900),
                                Color(0xffffcc00)
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

  void onCreateActorClick(name, des, quantity,bool isDelete,Tool tool,script) {
    tool.toolName = name;
    tool.toolDes = des;
    tool.isDelete = isDelete;
    tool.quantity = quantity;
    bloc.editTool(tool,script);
  }
}
