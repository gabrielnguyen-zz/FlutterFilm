import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getuserinfo.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:flutter_task_planner_app/dataprovider/usersetting.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class UserSettingBloc {
  StreamController userSettingStream = new StreamController();
  Stream get userSet => userSettingStream.stream;

  Future<bool> updateUser(context, Actor actor) async {
    userSettingStream.sink.add("Logging");
    var userSetting = UserSetting();
    var result = await userSetting.updateUserSetting(actor);
    print(result);
    if (!result) {
      OpenDialog.displayDialog("Error", context, "Error");
      userSettingStream.sink.add("Done");
      return false;
    } else {
      OpenDialog.displayDialog("Message", context, "Edit Info Success !!!");

      userSettingStream.sink.add("Done");
      return true;
    }
  }

  void dispose() {
    userSettingStream.close();
  }
}
