import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:http/http.dart' as http;

class GetAllActor {
  Future<List<Actor>> getAllActor() async {
    String url = apiUrl + "/api/Actors";
    print(url);
    List<Actor> list = List();
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final dataList = json.decode(response.body);
      for (var data in dataList) {
          var actorName = data['fullname'].toString();
          var actorID = data['username'].toString();
          var image = data['image'];
          var phone = data['phone'];
          var actorDes = data['description'];
          var email = data['email'];
          Actor actor = new Actor(
            actorId: actorID,
            actorName: actorName,
            actorDes: actorDes,
            image: image,
            phone: phone.toString(),
            email: email
          );
          list.add(actor);
        
      }
      return list;
    }
  }
}
