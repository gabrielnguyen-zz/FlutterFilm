import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getallactor.dart';
import 'package:flutter_task_planner_app/dataprovider/getalltool.dart';
import 'package:flutter_task_planner_app/dataprovider/getalltoolscene.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/models/toolscene.dart';


class GetAllToolSceneBloc {
  StreamController getAllToolSceneStream = new StreamController();
  StreamController userInfoStream = new StreamController();
  Stream get getUserInfo => userInfoStream.stream;
  Stream get getToolScenes => getAllToolSceneStream.stream;
  List<ToolScene> list ;
  Future<bool> getAllToolSceneFunction() async {
      print("bloc alo");
      var pref = await SharePreferencesProvider().getUserInfo();
      String user = pref.actorName + "`" + pref.email + "`" + pref.image;
      print(user);
      var getAllToolScene = GetAllToolScene();
      var result = await getAllToolScene.getAllToolScene();
      print(result);
      if (result == null) {
        getAllToolSceneStream.sink.add("Error");
        return false;
      } else {
        userInfoStream.sink.add(user);
        getAllToolSceneStream.sink.add(result);
        list = result;
        return true;
      }
    
  }
  void searchByName(String search){
    print(search);
    var result = list.where((element)=>element.toolName.toLowerCase().contains(search.toLowerCase())).toList();
    getAllToolSceneStream.sink.add(result);
  }
  void dispose() {
    getAllToolSceneStream.close();
    userInfoStream.close();
  }
}