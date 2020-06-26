import 'dart:async';
import 'package:flutter_task_planner_app/dataprovider/createactor.dart';
import 'package:flutter_task_planner_app/dataprovider/createtool.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/models/tool.dart';

class CreateToolBloc {
  StreamController createToolStream = new StreamController();
  Stream get createToolGet => createToolStream.stream;

  Future<bool> createTool(Tool tool) async {
     var create = CreateTool();
      var result = await create.create(tool);
      print(result);
      if (!result) {
        createToolStream.sink.add("Error");
        return false;
      } else {
        createToolStream.sink.add("Create Success!!!");
        return true;
      }
  }

  void dispose() {
    createToolStream.close();
  }
}
