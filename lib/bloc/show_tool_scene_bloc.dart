import 'dart:async';

import 'package:flutter_task_planner_app/dataprovider/addtooltoscene.dart';
import 'package:flutter_task_planner_app/dataprovider/getallscene.dart';
import 'package:flutter_task_planner_app/dataprovider/getalltool.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class ShowToolSceneBloc {
  StreamController showToolStream = new StreamController();
  StreamController showSceneStream = new StreamController();
  StreamController resultStream = new StreamController();
  Stream get showTools => showToolStream.stream;
  Stream get showScenes => showSceneStream.stream;
  Stream get result => resultStream.stream;
  List<String> listTools = List();
  List<String> listScenes = List();

  Future<bool> showToolScene() async {
    print("bloc alo");
    listTools.clear();
    listScenes.clear();
    var getAllTool = GetAllTool();
    var tools = await getAllTool.getAllTool();
    for (var tool in tools) {
      String newTool = tool.toolId + "." + tool.toolName + " - " + tool.quantity.toString();
      listTools.add(newTool);
    }

    print("toi scene");
    var getAllScene = GetAllScene();
    var scenes = await getAllScene.getAllScene();
    for (var scene in scenes) {
      String newScene = scene.sceneId.toString() + "." + scene.sceneName;
      listScenes.add(newScene);
      print(newScene);
    }
    if (listScenes.length > 0 && listTools.length > 0) {
      showToolStream.sink.add(listTools);
      showSceneStream.sink.add(listScenes);
      return true;
    }
    return false;
  }

  Future<bool> addToolToScene(context,
      dropDownTool, dropDownScene, quantity, toolFrom, toolTo) async {
        print("bloc aloo");
    if (dropDownTool == null ||
        dropDownScene == null ||
        quantity == null ||
        toolFrom.trim() == 'Pick Date' ||
        toolTo.trim() == 'Pick Date') {
      resultStream.sink.add("All Fields must not blank");
      print("cant be blank");
      return false;
    } else {
      var sceneId = dropDownScene.split(".")[0];
      var toolId = dropDownTool.split(".")[0];
      print(int.parse(dropDownTool.split("-")[1].trim()) >= int.parse(quantity));
      if (int.parse(dropDownTool.split("-")[1].trim()) >= int.parse(quantity)) {
        var addTool = AddToolScene();
        var result = await addTool.add(sceneId, toolId, quantity, toolFrom, toolTo);
        if (result) {
          OpenDialog.displayDialog("Message", context, "Add Tool to Scene Success");
          return true;
        } else {
          OpenDialog.displayDialog("Error", context, "Error!!!");
          return false;
        }
      } else {
        OpenDialog.displayDialog("Error", context, "Quantity must not larger than quantity in storage!!!");
            return false;
      }
    }
  }

  void dispose() {
    showToolStream.close();
    showSceneStream.close();
  }
}
