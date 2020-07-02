import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';

class AddToolScene{

  Future<bool> add(sceneId, toolId, quantity, toolFrom, toolTo) async {
    String url = apiUrl + "/api/SceneTools/";
    print(url);
    var body = jsonEncode({
      'sceneId': sceneId,
      'toolId': toolId,
      'quantity': quantity,
      'toolFrom': toolFrom,
      'toolTo': toolTo,
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