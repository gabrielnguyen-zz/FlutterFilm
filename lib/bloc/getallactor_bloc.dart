import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/getallactor.dart';
import 'package:flutter_task_planner_app/dataprovider/sharepreferences.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class GetAllActorBloc {
  StreamController getAllActorStream = new StreamController();
  StreamController userInfoStream = new StreamController();
  Stream get getUserInfo=> userInfoStream.stream;
  Stream get getActors => getAllActorStream.stream;
  List<Actor> list ;
  Future<bool> getAllActorFunction() async {
      print("shared alo");
      var pref = await SharePreferencesProvider().getUserInfo();
      String user = pref.actorName + "`" + pref.email + "`" + pref.image;
      print(user);
      var getAllActor = GetAllActor();
      var result = await getAllActor.getAllActor();
      print(result);
      if (result == null) {
        getAllActorStream.sink.add("Error");
        return false;
      } else {
        userInfoStream.sink.add(user);
        getAllActorStream.sink.add(result);
        list = result;
        return true;
      }
    
  }
  void searchByName(String search){
    print(search);
    var result = list.where((element)=>element.actorName.toLowerCase().contains(search.toLowerCase())).toList();
    getAllActorStream.sink.add(result);
  }
  void dispose() {
    getAllActorStream.close();
    userInfoStream.close();
  }
}