import 'dart:convert';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';


class CreateTool{

  Future<bool> create(Tool tool) async {
    String url = apiUrl + "/api/Tools/";
    print(url);
    var body = jsonEncode({
      'toolName': tool.toolName,
      'image': tool.image,
      'toolDes': tool.toolDes,
      'quantity': tool.quantity,
      'createdBy': "Admin",
      'updatedBy': "Admin",
      'status' : true,
      'isDelete': false
});
    print(body);
    var response =  await http.post(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.body + " " + response.body);
    if(response.statusCode == 201){
      return true;
    } else{ 
      return false;
    }
  }
}