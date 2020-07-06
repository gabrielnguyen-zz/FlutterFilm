import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:http/http.dart' as http;

class UserSetting {
  Future<bool> updateUserSetting(Actor actor) async {
    String url = apiUrl + "/api/Actors/" + actor.actorId;
    print(url);
    var date =  DateTime.now().toString().split(" ")[0];
    var body = jsonEncode({
      'actorID': actor.actorId,
      'actorName': actor.actorName,
      'image': actor.image,
      'actorDes': actor.actorDes,
      'phone': actor.phone,
      'email': actor.email,
      'createdTime': actor.createdTime,
      'createdBy': actor.createdBy,
      'updatedTime': date.toString(),
      'updatedBy': actor.accountId,
      'isDelete' : false,
      'accountId' : actor.accountId
    });
    print(body);
    var response =  await http.put(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if(response.statusCode == 204){
      return true;
    }
    return false;
  }
}
