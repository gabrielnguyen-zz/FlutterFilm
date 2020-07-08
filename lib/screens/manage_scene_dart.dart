import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/getallscene_bloc.dart';
import 'package:flutter_task_planner_app/screens/createscene.dart';
import 'package:flutter_task_planner_app/screens/createtool.dart';
import 'package:flutter_task_planner_app/screens/editscene.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/act_column.dart';
import 'package:flutter_task_planner_app/widgets/actor_column.dart';
import 'package:flutter_task_planner_app/widgets/top_container.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ManageSceneTaskPage extends StatefulWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  _ManageSceneTaskState createState() => _ManageSceneTaskState();
}

class _ManageSceneTaskState extends State<ManageSceneTaskPage> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  var bloc = GetAllSceneBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.getAllSceneFunction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: StreamBuilder(
                          stream: bloc.userInfoGet,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CircularPercentIndicator(
                                    radius: 90.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.75,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: LightColors.kRed,
                                    backgroundColor: Color.fromRGBO(3, 9, 23, 1),
                                    center: CircleAvatar(
                                      backgroundColor: Color.fromRGBO(149, 161, 203, 1),
                                      radius: 35.0,
                                      backgroundImage: snapshot.data.split("`")[2] !=null ? NetworkImage(snapshot.data.split("`")[2]) : AssetImage(
                                        'assets/images/avatar.png',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          snapshot.data.split("`")[0],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          snapshot.data.split("`")[1],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                ],
                              )
                            ],
                          );
                            }else{
                              return CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  );
                            }
                          
                        }
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Manage Scene",
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w900, fontSize: 28),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color:Colors.white)
                            ),
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              
                              children: [
                                Column(
                                  children: [
                                    TextField(
                                      
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        bloc.searchByName(value);
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 7.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 3.0),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Search by name',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          StreamBuilder(
                              stream: bloc.getScenes,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var listWidget = <Widget>[];
                                  snapshot.data.forEach((data) {
                                    listWidget.add(ActColumn(
                                      
                                      title: data.sceneId.toString() + ". " + data.sceneName,
                                      subtitle: data.sceneDes,
                                      onTap: () {
                                        print("tapped");
                                        Navigator.of(context)
                                            .push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditScenePage(data)),
                                            )
                                            .then((value) =>
                                                bloc.getAllSceneFunction());
                                      },
                                    ));
                                  });
                                  return Column(
                                    children: listWidget,
                                  );
                                } else {
                                  return CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                padding: EdgeInsets.all(20),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  backgroundColor: Colors.blue[800],
                  onPressed: () {
                    print('btnAdd Clicked');
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (context) => CreateScenePage()),
                        )
                        .then((value) => bloc.getAllSceneFunction());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
