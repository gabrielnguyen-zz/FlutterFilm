import 'dart:async';
import 'package:flutter_task_planner_app/dataprovider/createactor.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class UploadSceneScriptBloc {
  StreamController uploadSceneScriptStream = new StreamController();
  Stream get createActorGet => uploadSceneScriptStream.stream;

  // Future<bool> uploadSceneScript( ) async {
     
  //     if (!result) {
  //       uploadSceneScriptStream.sink.add("Error");
  //       return false;
  //     } else {
  //       uploadSceneScriptStream.sink.add("Create Success!!!");
  //       return true;
  //     }
  // }

  void dispose() {
    uploadSceneScriptStream.close();
  }
}
