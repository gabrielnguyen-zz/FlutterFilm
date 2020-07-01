import 'package:flutter/material.dart';
import 'package:flutter_task_planner_app/bloc/getallscene_bloc.dart';
import 'package:flutter_task_planner_app/screens/createtool.dart';
import 'package:flutter_task_planner_app/screens/editscene.dart';
import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
import 'package:flutter_task_planner_app/widgets/act_column.dart';
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
  Widget build(BuildContext context) {
    bloc.getAllSceneFunction();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
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
                      child: Row(
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
                            backgroundColor: LightColors.kDarkYellow,
                            center: CircleAvatar(
                              backgroundColor: LightColors.kBlue,
                              radius: 35.0,
                              backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Administation",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 28),
                          ),
                          Container(
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
                                        color: Color(0xFF212121),
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFE6EE9C),
                                              width: 7.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFFFCCBC),
                                              width: 3.0),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Color(0xFF212121),
                                        ),
                                        hintText: 'Search by name',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF212121),
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
                                            Colors.orange),
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
                  backgroundColor: LightColors.kDarkYellow,
                  onPressed: () {
                    print('btnAdd Clicked');
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                              builder: (context) => CreateToolPage()),
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
