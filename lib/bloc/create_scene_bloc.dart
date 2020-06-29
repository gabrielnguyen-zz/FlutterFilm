import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/createscene.dart';
import 'package:flutter_task_planner_app/models/scene.dart';

class CreateSceneBloc {
  StreamController createSceneStream = new StreamController();
  Stream get createSceneGet => createSceneStream.stream;

  Future<bool> createTool(Scene scene, script) async {
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
    }
    var create = CreateScene();
    var result = await create.create(scene);
    print(result);
    if (!result) {
      createSceneStream.sink.add("Error");
      return false;
    } else {
      createSceneStream.sink.add("Create Success!!!");
      return true;
    }
  }

  void dispose() {
    createSceneStream.close();
  }
}
