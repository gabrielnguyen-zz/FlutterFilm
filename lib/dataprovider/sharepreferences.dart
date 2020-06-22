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

    
}