import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getscene.dart';
import 'package:flutter_task_planner_app/dataprovider/getuserinfo.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewActBloc {
  StreamController viewActStream = new StreamController();
  StreamController linkStream = new StreamController();
  Stream get viewAct => viewActStream.stream;
  Stream get link => linkStream.stream;

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
  Future<bool> viewDownloadFileUrl(int sceneId) async {
    var getScene = GetScene();
    var result = await getScene.getScene(sceneId);
    print(result);
    if(result != null){
      print("co reuslt");
      if(await canLaunch(result.sceneActors)){
        await launch(result.sceneActors);
        return true;
      }else{
      linkStream.sink.add("Cant launch browser");
      return false;
      }
    }else{
      linkStream.sink.add("Cant get URL");
      return false;
    }
  }

  void dispose() {
    viewActStream.close();
    linkStream.close();
  }
}
