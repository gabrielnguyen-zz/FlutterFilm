import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:http/http.dart' as http;

class GetScene {
  Future<Scene> getScene(int sceneId) async {
    String url = apiUrl + "/api/Scenes/" + sceneId.toString();
    print(url);
    Scene scene;
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      print("alo");
      var sceneName = dataList['sceneName'].toString();
      var sceneId = dataList['sceneId'].toString();
      var sceneDes = dataList['sceneDes'];
      var sceneLoc = dataList['sceneLoc'];
      var sceneTimeStart = dataList['sceneTimeStart'].split("T")[0];
      var sceneTimeStop = dataList['sceneTimeStop'].split("T")[0];
      var sceneRec = dataList['sceneRec'].toString();
      var sceneActors = dataList['sceneActors'];
      scene = Scene(
          sceneId: int.parse(sceneId),
          sceneName: sceneName,
          sceneDes: sceneDes,
          sceneLoc: sceneLoc,
          sceneTimeStart: sceneTimeStart,
          scenetTimeStop: sceneTimeStop,
          sceneRec: int.parse(sceneRec),
          sceneActors: sceneActors);
      return scene;
    } else {
      return null;
    }
  }
}
