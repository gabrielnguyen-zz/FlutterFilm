import 'dart:convert';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';


class EditScene{

  Future<bool> editScene(Scene scene) async {
    String url = apiUrl + "/api/Scenes/" + scene.sceneId.toString();
    print(url);
    var body = jsonEncode({
      'id': scene.sceneId,
      'title': scene.sceneName,
      'description': scene.sceneDes,
      'dateBegin': scene.sceneTimeStart,
      'dateEnd' : scene.scenetTimeStop,
      'scripts' : scene.sceneActors
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