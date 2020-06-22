import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:http/http.dart' as http;
class GetUserInfo{

  Future<Actor> getUserInfo(String accountID) async {
    print("get user info alo");
    String url = apiUrl + "/api/Actors/accountID/" + accountID;
    print(url);
    var response = await http.get(Uri.encodeFull(url),headers: {"Content-Type": "application/json"});
    print(response.body);
    if(response.statusCode == 200){
      final data  = json.decode(response.body);
        var actorName  = data['actorName'].toString();
        var image = data['image'];
        var phone = data['phone'];
        var actorDes = data['actorDes'];
        var email = data['email'];
        int done = 0,inProgress = 0 ,waiting = 0;
        List scenes = data['sceneActor'];
        for(var scene in scenes){
          var status = scene['status'].toString();
          if(status == statusDone){
            done = done + 1;
          }else if(status == statusInProgress){
            inProgress = inProgress + 1;
          }else{
            waiting = waiting + 1;
          }
        }
        Actor actor = new Actor(
          actorName: actorName,
          actorDes: actorDes,
          image: image,
          phone: phone,
          email: email,
          inProgress: inProgress,
          done: done,
          waiting: waiting
        );
        return actor;
    }
  }
}