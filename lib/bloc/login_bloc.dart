
import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/login.dart';

class LoginBloc{

  StreamController user =  new StreamController();
  StreamController notSignup = new StreamController();
  Stream get userStream =>user.stream;
  Stream get notSignUpStream => notSignup.stream;
  Future<bool> checkLogin(String accountID, String password) async {
    print("bloc ");
    var login =  LoginValidations();
    var result = await login.checkLogin(accountID, password);
    print(result);
    if(result!=null){
      user.sink.add(result);
      return true;
    }else{
      notSignup.sink.add("Not signed up yet");
      return false;
    }
  }

  void dispose(){
    user.close();
  }

}