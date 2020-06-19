
import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/login_bloc.dart';

import 'package:flutter_task_planner_app/screens/login.dart';
import 'package:flutter_task_planner_app/screens/menu.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  LoginBloc bloc  = LoginBloc();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: LightColors.kDarkBlue,
              displayColor: LightColors.kDarkBlue,
              fontFamily: 'Poppins'
            ),
      ),
      //home: MenuPage(),
      home: createContent(),
      debugShowCheckedModeBanner: false,
    );
  }


  Widget createContent(){
    return StreamBuilder(
      stream: bloc.isLoggedStream,
      builder: (context, snapshot){
        print("login");
        if(snapshot.data ==null){
          print("chua dang nhap");
          return LoginPage();
          
        }else{
          print("dang nhap");
          return MenuPage();
        }
        
      },
    );
  }
}
