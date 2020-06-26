import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/create_actor_bloc.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:flutter_task_planner_app/widgets/back_button.dart';
import 'package:flutter_task_planner_app/widgets/my_text_field.dart';

class CreateActorPage extends StatelessWidget {
  TextEditingController actorNameController = TextEditingController();
  TextEditingController actorDesController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var bloc = CreateActorBloc();
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
                        'Create new actor',
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
                          label: 'Actor Name', controller: actorNameController),
                      MyTextField(
                        label: 'Username',
                        controller: usernameController,
                      ),
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
                        label: 'Mail',
                        controller: emailController,
                      )),
                      SizedBox(width: 40),
                      Expanded(
                        child: MyTextField(
                          label: 'Phone',
                          controller: phoneController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    label: 'Description',
                    controller: actorDesController,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.black87),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black45),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: bloc.createActorGet,
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
                        'Create Task',
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
    
    String name = actorNameController.text;
    String des =  actorDesController.text;
    String phone = phoneController.text;
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;
    Actor actor = Actor(
      actorName: name,
      actorDes: des,
      phone: phone,
      email: email,
      accountId: username,
      password: password,
      createdBy: username,
      updatedBy: username,
      image: "aloha"
    );
    bloc.createActor(actor);
  }
}
