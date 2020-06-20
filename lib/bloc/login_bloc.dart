
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/screens/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task_planner_app/dataprovider/login.dart';

class LoginBloc{

  StreamController user =  new StreamController();
  StreamController notSignup = new StreamController();
  StreamController isLogged = new StreamController();
  Stream get isLoggedStream => isLogged.stream;
  Stream get userStream =>user.stream;
  Stream get notSignUpStream => notSignup.stream;
  Future<bool> checkLogin(context,String accountID, String password) async {
    print("bloc ");
    var login =  LoginValidations();
    var result = await login.checkLogin(accountID, password);
    print(result);
    if(result!=null){
      openSession(result);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              if(result == 'admin'){
                return ActorMenuPage();
              }else{
                return null;
              }
            }
          )
        );
      return true;
    }else{
      notSignup.sink.add("Not signed up yet");
      return false;
    }
  }


  void dispose(){
    user.close();
    notSignup.close();
    isLogged.close();
  }

  void openSession(String role) async {
    SharedPreferences  pref =  await SharedPreferences.getInstance();
    await pref.setString("role", role);
    isLogged.sink.add(true);
  }

  void closeSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("role");
    isLogged.sink.add(false);
  }
}