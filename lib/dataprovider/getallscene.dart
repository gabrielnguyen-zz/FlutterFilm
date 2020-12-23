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
          var sceneName = data['title'].toString();
          var sceneId = data['id'].toString();
          var sceneDes = data['description'];
          var sceneTimeStart = data['dateBegin'].split("T")[0];
          var sceneTimeStop = data['dateEnd'].split("T")[0];
          var sceneActors = data['script'];
          Scene scene = Scene(
            sceneId: int.parse(sceneId),
            sceneName: sceneName,
            sceneDes: sceneDes,
            sceneTimeStart: sceneTimeStart,
            scenetTimeStop: sceneTimeStop,
            sceneActors: sceneActors
          );
          list.add(scene);
        
      }
      return list;
    }
  }
}
