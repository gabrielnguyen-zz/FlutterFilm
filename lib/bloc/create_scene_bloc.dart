import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/createscene.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class CreateSceneBloc {
  StreamController createSceneStream = new StreamController();
  Stream get createSceneGet => createSceneStream.stream;

  Future<bool> createTool(context, Scene scene, script) async {
    createSceneStream.sink.add("Logging");
    if (script != null && script.filename != null && script.file != null) {
      print('start upload');
      var filename = script.filename +
          "-" +
          DateTime.now().toString() +
          "." +
          script.fileExtension;

      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('Tool/' + filename);

      StorageUploadTask uploadTask = storageReference.putFile(script.file);

      await uploadTask.onComplete;

      print('Uploaded');

      await storageReference.getDownloadURL().then((value) {
        print(value);
        scene.sceneActors = value;
      });
    } else {
      createSceneStream.sink.add("Done");
    }
    var create = CreateScene();
    var result = await create.create(scene);
    print(result);
    if (!result) {
      OpenDialog.displayDialog("Error", context, "Error!!!");
      createSceneStream.sink.add("Done");

      return false;
    } else {
      OpenDialog.displayDialog("Message", context, "Create Success!!!");
      createSceneStream.sink.add("Done");

      return true;
    }
  }

  void dispose() {
    createSceneStream.close();
  }
}
