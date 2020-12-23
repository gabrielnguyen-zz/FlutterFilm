import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class CreateActor {
  Future<bool> create(Actor actor) async {
    String url = apiUrl + "/api/Actors/";
    print(url);
    actor.isDelete = false;
    var body = jsonEncode({
      'fullname': actor.actorName,
      'image': actor.image,
      'description': actor.actorDes,
      'phone': actor.phone,
      'email': actor.email,
      'usernameNavigation': {
        'username': actor.accountId,
        'password': actor.password,
        'role' : 'user'
      }
    });
    print(body);
    var response = await http.post(Uri.encodeFull(url),
        body: body, headers: {"Content-Type": "application/json"});
    print(response.body + " " + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
