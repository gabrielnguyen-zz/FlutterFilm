import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getallactor.dart';
import 'package:flutter_task_planner_app/dataprovider/getalltool.dart';
import 'package:flutter_task_planner_app/models/tool.dart';


class GetAllToolBloc {
  StreamController getAllToolStream = new StreamController();
  Stream get getActors => getAllToolStream.stream;
  List<Tool> list ;
  Future<bool> getAllToolFunction() async {
      print("bloc alo");
      var getAllTool = GetAllTool();
      var result = await getAllTool.getAllTool();
      print(result);
      if (result == null) {
        getAllToolStream.sink.add("Error");
        return false;
      } else {
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
  }
}