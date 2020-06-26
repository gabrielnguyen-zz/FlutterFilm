import 'dart:async';
import 'package:flutter_task_planner_app/dataprovider/edittool.dart';
import 'package:flutter_task_planner_app/models/tool.dart';

class EditToolBloc {
  StreamController editToolStream = new StreamController();
  Stream get editToolGet => editToolStream.stream;

  Future<bool> editTool(Tool tool) async {
     var edit = EditTool();
      var result = await edit.editTool(tool);
      print(result);
      if (!result) {
        editToolStream.sink.add("Error");
        return false;
      } else {
        editToolStream.sink.add("Success!!!");
        return true;
      }
  }

  void dispose() {
    editToolStream.close();
  }
}
