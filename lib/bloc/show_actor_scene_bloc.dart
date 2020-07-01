import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/addactortoscene.dart';
import 'package:flutter_task_planner_app/dataprovider/getallactor.dart';
import 'package:flutter_task_planner_app/dataprovider/getallscene.dart';
import 'package:flutter_task_planner_app/screens/addactortoscene.dart';

class ShowActorSceneBloc {
  StreamController showActorStream = new StreamController();
  StreamController showSceneStream = new StreamController();
  StreamController resultStream = new StreamController();
  Stream get showActors => showActorStream.stream;
  Stream get showScenes => showSceneStream.stream;
  Stream get result => resultStream.stream;
  List<String> listActors = List();
  List<String> listScenes = List();

  Future<bool> showActorScene() async {
      print("bloc alo");
      listActors.clear();
      listScenes.clear();
      var getAllActor = GetAllActor();
      var actors = await getAllActor.getAllActor();
      for(var actor in actors){
        String newActor = actor.actorId + "." + actor.actorName;
        listActors.add(newActor);
        print("alo " + newActor);
      }
      
      print("toi scene");
      var getAllScene = GetAllScene();
      var scenes = await getAllScene.getAllScene();
      for(var scene in scenes){
        String newScene = scene.sceneId.toString() + "." + scene.sceneName;
        listScenes.add(newScene);
        print(newScene);
      }
      if(listScenes.length >0 && listActors.length > 0 ){
        showActorStream.sink.add(listActors);
        showSceneStream.sink.add(listScenes);
        return true;
      }
      return false;
  }

  Future<bool> addActorToScene(dropDownActor, dropDownScene, character,actFrom,actTo, status) async {
    if(dropDownActor == null || dropDownScene == null || character.trim == '' || actFrom.trim() == '' || actTo.trim() == '' || status == null){
      resultStream.sink.add("All Fields must not blank");
      return false;
    }else{
      var sceneId = dropDownScene.split(".")[0];
      var actorId = dropDownActor.split(".")[0];
      var addActor = AddActorScene();
      var result = await addActor.add(sceneId, actorId, character, status, actFrom, actTo);
      if(result){
        resultStream.sink.add("Add Success !!!!");
        return true;
      }else{
        resultStream.sink.add("Error");
      }
    }
  }
  void dispose() {
    showActorStream.close();
    showSceneStream.close();
  }
}