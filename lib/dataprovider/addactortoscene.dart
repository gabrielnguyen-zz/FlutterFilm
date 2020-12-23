import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class AddActorScene{

  Future<bool> add(sceneId, actorId, character, status, actFrom, actTo ) async {
    String url = apiUrl + "/api/SceneActors/";
    print(url);
    var body = jsonEncode({
      'sceneId': sceneId,
      'actorUsername': actorId,
      'character': character,
      'status': status,
      'actFrom': actFrom,
      'actTo': actTo,
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