import 'dart:async';
import 'dart:convert';
import 'package:flutter_task_planner_app/dataprovider/getuserinfo.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfoBloc {
  StreamController userInfoStream = new StreamController();
  Stream get userInfo => userInfoStream.stream;

  Future<bool> getAllStatusScene() async {
    SharePreferencesProvider sharePreferences = SharePreferencesProvider();
    String accountID = await sharePreferences.getAccountId();
    print("accountID " + accountID);
    if (accountID != null) {
      print("bloc alo");
      var getUserInfo = GetUserInfo();
      var result = await getUserInfo.getUserInfo(accountID);
      print(result);
      if (result == null) {
        
        userInfoStream.sink.add("Error");
        return false;
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("account", json.encode(result));
        userInfoStream.sink.add(result);
        return true;
      }
    }
  }

  void dispose() {
    userInfoStream.close();
  }
}
