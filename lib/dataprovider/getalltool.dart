import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/tool.dart';

import 'package:http/http.dart' as http;

class GetAllTool {
  Future<List<Tool>> getAllTool() async {
    String url = apiUrl + "/api/Tools";
    print(url);
    List<Tool> list = List();
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      for (var data in dataList) {
        var isDelete = data['isDelete'].toString();
        if (isDelete == 'false') {
          var toolName = data['toolName'].toString();
          var toolId = data['toolId'].toString();
          var image = data['image'];
          var quantity = data['quantity'];
          var toolDes = data['toolDes'];
          var status = data['status'];
          var createdTime = data['createdTime'];
          var createdBy = data['createdBy'];
          var updatedTime = data['updatedTime'];
          var updatedBy = data['updatedBy'];
          Tool tool = new Tool(
            toolId: toolId,
            toolName: toolName,
            toolDes: toolDes,
            image: image,
            quantity: quantity,
            status: status,
            createdTime: createdTime,
            createdBy: createdBy,
            updatedBy: updatedBy,
            updatedTime: updatedTime,
          );
          list.add(tool);
        }
      }
      return list;
    }
  }
}
