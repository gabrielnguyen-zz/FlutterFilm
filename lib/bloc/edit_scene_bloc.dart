import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/editscene.dart';
import 'package:flutter_task_planner_app/models/scene.dart';

class EditSceneBloc {
  StreamController editSceneStream = new StreamController();
  Stream get editSceneGet => editSceneStream.stream;

  Future<bool> editScene(Scene scene,script) async {
    print(script);
    if (script != null && script.filename != null && script.file != null) {
      print('start upload');
      var filename = script.filename +
          "-" +
          DateTime.now().toString() +
          "." +
          script.fileExtension;

      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('Scene/' + filename);

      StorageUploadTask uploadTask = storageReference.putFile(script.file);

      await uploadTask.onComplete;

      print('Uploaded');

      await storageReference.getDownloadURL().then((value) {
        print(value);
        scene.sceneActors = value;
      });
      print(scene.sceneActors);
      var edit = EditScene();
      var result = await edit.editScene(scene);
      print(result);
      if (!result) {
        editSceneStream.sink.add("Error");
        return false;
      } else {
        editSceneStream.sink.add("Success!!!");
        return true;
      }
    }
     
  }

  void dispose() {
    editSceneStream.close();
  }
}
