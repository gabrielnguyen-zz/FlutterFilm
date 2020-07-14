import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/models/toolscene.dart';
import 'package:http/http.dart' as http;

class GetAllToolScene {
  Future<List<ToolScene>> getAllToolScene() async {
    String url = apiUrl + "/api/SceneTools";
    print(url);
    List<ToolScene> list = List();
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      for (var data in dataList) {
        var sceneId = data['sceneId'];
        print(sceneId);
        var toolId = data['toolId'];
        var quantity = data['quantity'];
        var toolFrom = data['toolFrom'];
        var toolTo = data['toolTo'];
        var toolName, sceneName;
        String getToolNameUrl = apiUrl + "/api/Tools/" + toolId.toString();
        print("vao tool");
        var toolResult= await http.get(Uri.encodeFull(getToolNameUrl),
            headers: {"Content-Type": "application/json"});
        if (toolResult.statusCode == 200) {
          final toolData = json.decode(toolResult.body);
          toolName = toolData['toolName'];
          print("toolName" + toolName);
        }
        String getSceneNameUrl = apiUrl + "/api/Scenes/" + sceneId.toString();
        print("vao tool");
        var sceneResult= await http.get(Uri.encodeFull(getSceneNameUrl),
            headers: {"Content-Type": "application/json"});
        if (sceneResult.statusCode == 200) {
          final sceneData = json.decode(sceneResult.body);
          sceneName = sceneData['sceneName'];
        }
        ToolScene toolScene = ToolScene(
          toolId: sceneId,
          toolFrom: toolFrom,
          toolTo: toolTo,
          quantity: int.parse(quantity),
          toolName: toolName,
          sceneName: sceneName
        );
        list.add(toolScene);
      }
    }
    return list;
  }
}
