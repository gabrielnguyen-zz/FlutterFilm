import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/screens/admin_home_page.dart';
import 'package:flutter_task_planner_app/screens/admin_menu.dart';
import 'package:flutter_task_planner_app/screens/home_page.dart';
import 'package:flutter_task_planner_app/screens/menu.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task_planner_app/dataprovider/login.dart';

class LoginBloc {
  StreamController user = new StreamController();

  StreamController isLogging = new StreamController();
  Stream get isLoggingStream => isLogging.stream;
  Stream get userStream => user.stream;

  Future<bool> checkLogin(context, String accountID, String password) async {
    isLogging.sink.add("Logging");
    print("bloc ");
    var login = LoginValidations();
    var result = await login.checkLogin(accountID, password);
    print(result);
    if (result != null) {
      openSession(accountID, result);
      print(result);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (result == 'user') {
          return ActorMenuPage(
            screen: HomePage(),
          );
        } else if (result == 'admin') {
          return AdminMenuPage(screen: AdminHomePage());
        }
      }));
      return true;
    } else {
      isLogging.sink.add("Done");
      OpenDialog.displayDialog("Error",context, "Wrong username or password!");
      return false;
    }
  }

  

  void dispose() {
    user.close();
    isLogging.close();
  }

  void openSession(String accountId, String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("role", role);
    await pref.setString("accountID", accountId);
  }

  void closeSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("role");
    pref.remove("accountID");
  }
}
