import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/create_actor_bloc.dart';
import 'package:flutter_task_planner_app/bloc/create_tool_bloc.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';

class CreateToolPage extends StatelessWidget {
  TextEditingController toolNameController = TextEditingController();
  TextEditingController toolDesController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  //TextEditingController imageController = TextEditingController();
  var bloc = CreateToolBloc();
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    
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
                        'Create new tool',
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
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: bloc.createToolGet,
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
                print("created");
                FocusScope.of(context).unfocus();
                onCreateActorClick();
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
  void onCreateActorClick(){
    
    String name = toolNameController.text;
    String des =  toolDesController.text;
    int quantity = int.parse(quantityController.text);
    Tool tool = Tool(
      toolName: name,
      toolDes: des,
      quantity: quantity,
      image: "aloha"
    );
    bloc.createTool(tool);
  }
}
