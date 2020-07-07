import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getallactor.dart';
import 'package:flutter_task_planner_app/dataprovider/getalltool.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:flutter_task_planner_app/models/tool.dart';


class GetAllToolBloc {
  StreamController getAllToolStream = new StreamController();
  StreamController userInfoStream = new StreamController();
  Stream get getUserInfo => userInfoStream.stream;
  Stream get getTools => getAllToolStream.stream;
  List<Tool> list ;
  Future<bool> getAllToolFunction() async {
      print("bloc alo");
      var pref = await SharePreferencesProvider().getUserInfo();
      String user = pref.actorName + "`" + pref.email + "`" + pref.image;
      print(user);
      var getAllTool = GetAllTool();
      var result = await getAllTool.getAllTool();
      print(result);
      if (result == null) {
        getAllToolStream.sink.add("Error");
        return false;
      } else {
        userInfoStream.sink.add(user);
        getAllToolStream.sink.add(result);
        list = result;
        return true;
      }
    
  }
  void searchByName(String search){
    print(search);
    var result = list.where((element)=>element.toolName.toLowerCase().contains(search.toLowerCase())).toList();
    getAllToolStream.sink.add(result);
  }
  void dispose() {
    getAllToolStream.close();
    userInfoStream.close();
  }
}