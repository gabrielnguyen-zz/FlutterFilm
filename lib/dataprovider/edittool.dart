import 'dart:convert';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';


class EditTool{

  Future<bool> editTool(Tool tool) async {
    String url = apiUrl + "/api/Tools/" + tool.toolId;
        var date =  DateTime.now().toString().split(" ")[0];
    print(url);
    var body = jsonEncode({
      'toolId': tool.toolId,
      'toolName': tool.toolName,
      'image': tool.image,
      'toolDes': tool.toolDes,
      'quantity': tool.quantity,
      'createdBy': "Admin",
      'createdTime' : tool.createdTime,
      'updatedTime' : date.toString(),
      'updatedBy': "Admin",
      'status' : true,
      'isDelete': tool.isDelete
});
    print(body);
    var response =  await http.put(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.body + " " + response.body);
    if(response.statusCode == 204){
      return true;
    } else{ 
      return false;
    }
  }
}