import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/login_bloc.dart';
import 'package:flutter_task_planner_app/bloc/navigation_bloc.dart';

import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(LoginPage());
  

class LoginPage extends StatelessWidget with NavigationStates{
  TextEditingController accountController = TextEditingController();
  TextEditingController passController = TextEditingController();
  LoginBloc bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: LightColors.kLightYellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text("Hello\nWelcome To \nNguyen Entertainment", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child:TextField(
                  controller: accountController,
                  style: TextStyle(fontSize:18, color: Colors.black),
                  decoration: InputDecoration(
                    labelText:"USERNAME",
                    labelStyle: TextStyle(color: Color(0xff888888), 
                    fontSize: 15),
                  ),
                ) 
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child:StreamBuilder(
                stream: bloc.notSignUpStream,
                builder: (context, snapshot)=> TextField(
                      controller: passController,
                      style: TextStyle(fontSize:18, color: Colors.black),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText:"PASSWORD",
                        errorText: snapshot.hasError? snapshot.error : null,
                        labelStyle: TextStyle(color: Color(0xff888888), fontSize: 15),
                      )
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child:  RaisedButton(
                      color: LightColors.kDarkYellow,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed:onSignInClicked,
                      child: Text(
                        "SIGN IN",
                      style: TextStyle(color: Colors.white,fontSize:16),),
                  )
                  ),
                
              ),
              new Container(
                child: StreamBuilder(
                stream: bloc.userStream,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    loginNagivator(snapshot.data, context,snapshot.error);
                  }
                return Container();
                  } 
                ),
              ),
            ]
          ) ,
        )
        
      ),
    );
  }
  void onSignInClicked(){
    String accountID = accountController.text;
    String password = passController.text;
    bloc.checkLogin(accountID, password);
    
  }
  void loginNagivator(String data, BuildContext context,String error){
    print(data);
    if(data == 'admin'){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
    }else if(data == 'user'){
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
    }else{
      Fluttertoast.showToast(msg: error,
                            toastLength: Toast.LENGTH_LONG,
                            );
    }
  } 
}