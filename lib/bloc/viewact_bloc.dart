import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getuserinfo.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';

class ViewActBloc {
  StreamController viewActStream = new StreamController();
  Stream get viewAct => viewActStream.stream;

  Future<bool> viewActBasedOnTitle() async {
    SharePreferencesProvider sharePreferences = SharePreferencesProvider();
    String title = await sharePreferences.getTitle();
    String accountID = await sharePreferences.getAccountId();
    print("title " + title);
    if (title != null) {
      var getUserInfo = GetUserInfo();
      var result = await getUserInfo.getUserAct(accountID,title);
      print(result);
      if (result == null) {
        viewActStream.sink.add("Error");
        return false;
      } else {
        viewActStream.sink.add(result);
        return true;
      }
    }
  }

  void dispose() {
    viewActStream.close();
  }
}
