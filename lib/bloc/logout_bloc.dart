

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/login.dart';

import 'login_bloc.dart';

class LogoutBLoc{

  void pressLogOut(context){
    print("logout");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
    LoginBloc().closeSession();

  }
}