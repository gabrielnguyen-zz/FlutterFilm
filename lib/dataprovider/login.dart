import 'dart:convert';

import 'package:flutter_task_planner_app/constants/constants.dart';
import 'package:http/http.dart' as http;
class LoginValidations{

  Future<String> checkLogin (String accountID, String password) async {
    print("validation alo");
    String url = apiUrl + "/api/Accounts/login";
    print("url " + url);
    var body = jsonEncode({'username': accountID , 'password' : password});
    print(body);
    var response =  await http.post(Uri.encodeFull(url), body: body, headers: {"Content-Type": "application/json"});
    print(response.body);
    print(response.statusCode);
    if(response.statusCode ==200 ){
      final data = json.decode(response.body);
      return data['role'];  
    }else{
      return null;
    }
  }
}