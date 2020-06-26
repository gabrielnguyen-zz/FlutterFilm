import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class CreateActor{

  Future<bool> create(Actor actor) async {
    String url = apiUrl + "/api/Actors/";
    print(url);
    var body = jsonEncode({
      'actorName': actor.actorName,
      'image': actor.image,
      'actorDes': actor.actorDes,
      'phone': actor.phone,
      'email': actor.email,
      'createdBy': actor.createdBy,
      'updatedBy': actor.accountId,
      'accountId' : actor.accountId,
      'password' : actor.password
    });
    print(body);
    var response =  await http.post(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.body + " " + response.body);
    if(response.statusCode == 201){
      return true;
    } else{ 
      return false;
    }
  }
}