

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/login.dart';

import 'login_bloc.dart';

class LogoutBLoc{

  Future<void> pressLogOut(context) async {
    print("logout");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);
    LoginBloc().closeSession();
  }
}