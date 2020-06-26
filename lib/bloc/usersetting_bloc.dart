import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getuserinfo.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:flutter_task_planner_app/dataprovider/usersetting.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class UserSettingBloc {
  StreamController userSettingStream = new StreamController();
  Stream get userSet => userSettingStream.stream;

  Future<bool> updateUser(Actor actor) async {
    
      var userSetting = UserSetting();
      var result = await userSetting.updateUserSetting(actor);
      print(result);
      if (!result) {
        userSettingStream.sink.add("Error");
        return false;
      } else {
        userSettingStream.sink.add("Edit Success!!!");
        return true;
      }
  }

  void dispose() {
    userSettingStream.close();
  }
}
