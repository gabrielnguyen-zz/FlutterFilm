import 'dart:async';


import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesProvider{
  
  Future<String> getAccountId() async {
    print("bloc alo");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String account = pref.getString("accountID");
    if(account != null){
      return account;
    }
    return null;
  }


  Future<String> getTitle() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String title = pref.getString("Act");
    if(title!= null){
      return title;
    }else{
      return null;
    }
  }
  
  Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("Name");
    return name;
  }
}