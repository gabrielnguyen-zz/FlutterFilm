import 'dart:convert';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';


class CreateScene{

  Future<bool> create(Scene scene) async {
   String url = apiUrl + "/api/Scenes/";
    print(url);
    var body = jsonEncode({
      'title': scene.sceneName,
      'description': scene.sceneDes,
      'dateBegin': scene.sceneTimeStart,
      'dateEnd' : scene.scenetTimeStop,
      'script' : scene.sceneActors
});
    print(body);
    var response =  await http.post(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.statusCode.toString() + " aloha " + response.body);
    if(response.statusCode == 201){
      return true;
    } else{ 
      return false;
    }
  }
}