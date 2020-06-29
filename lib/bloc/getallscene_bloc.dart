import 'dart:async';
import 'package:flutter_task_planner_app/dataprovider/getallscene.dart';
import 'package:flutter_task_planner_app/models/scene.dart';



class GetAllSceneBloc {
  StreamController getAllSceneStream = new StreamController();
  Stream get getScenes => getAllSceneStream.stream;
  List<Scene> list ;
  Future<bool> getAllSceneFunction() async {
      print("bloc alo");
      var getAllScene = GetAllScene();
      var result = await getAllScene.getAllScene();
      print(result);
      if (result == null) {
        getAllSceneStream.sink.add("Error");
        return false;
      } else {
        getAllSceneStream.sink.add(result);
        list = result;
        return true;
      }
    
  }
  void searchByName(String search){
    print(search);
    var result = list.where((element)=>element.sceneName.toLowerCase().contains(search.toLowerCase())).toList();
    getAllSceneStream.sink.add(result);
  }
  void dispose() {
    getAllSceneStream.close();
  }
}