
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/admin_home_page.dart';
import 'package:flutter_task_planner_app/screens/admin_menu.dart';
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
      openSession(accountID,result);
      print(result);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              if(result == 'user'){
                return ActorMenuPage(screen: HomePage(),);
              }else 
              if(result == 'admin'){
                return AdminMenuPage(screen: AdminHomePage());
              }
              else{
                return Container(width:0,height:0);
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

  void openSession(String accountId,String role) async {
    SharedPreferences  pref =  await SharedPreferences.getInstance();
    await pref.setString("role", role);
    await pref.setString("accountID", accountId);
    isLogged.sink.add(true);
  }

  void closeSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("role");
    pref.remove("accountID");
    isLogged.sink.add(false);
  }
}