import 'dart:async';
import 'package:flutter_task_planner_app/dataprovider/createactor.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class CreateActorBloc {
  StreamController createActorStream = new StreamController();
  Stream get createActorGet => createActorStream.stream;

  Future<bool> createActor(Actor actor) async {
     var create = CreateActor();
      var result = await create.create(actor);
      print(result);
      if (!result) {
        createActorStream.sink.add("Error");
        return false;
      } else {
        createActorStream.sink.add("Create Success!!!");
        return true;
      }
  }

  void dispose() {
    createActorStream.close();
  }
}
