import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:http/http.dart' as http;

class GetAllScene {
  Future<List<Scene>> getAllScene() async {
    String url = apiUrl + "/api/Scenes";
    print(url);
    List<Scene> list = List();
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      for (var data in dataList) {
        var isDelete = data['isDelete'].toString();
        if (isDelete == 'false') {
          var sceneName = data['sceneName'].toString();
          var sceneId = data['sceneId'].toString();
          var sceneDes = data['sceneDes'];
          var sceneLoc = data['sceneLoc'];
          var sceneTimeStart = data['sceneTimeStart'].split("T")[0];
          var sceneTimeStop = data['sceneTimeStop'].split("T")[0];
          var sceneRec = data['sceneRec'].toString();
          var sceneActors = data['sceneActors'];
          Scene scene = Scene(
            sceneId: int.parse(sceneId),
            sceneName: sceneName,
            sceneDes: sceneDes,
            sceneLoc: sceneLoc,
            sceneTimeStart: sceneTimeStart,
            scenetTimeStop: sceneTimeStop,
            sceneRec: int.parse(sceneRec),
            sceneActors: sceneActors
          );
          list.add(scene);
        }
      }
      return list;
    }
  }
}
