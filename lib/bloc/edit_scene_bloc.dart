import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/editscene.dart';
import 'package:flutter_task_planner_app/models/scene.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class EditSceneBloc {
  StreamController editSceneStream = new StreamController();
  Stream get editSceneGet => editSceneStream.stream;

  Future<bool> editScene(context, Scene scene, script) async {
    editSceneStream.sink.add("Logging");
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
      
      
    }
    var edit = EditScene();
      var result = await edit.editScene(scene);
      print(result);
      if (!result) {
        OpenDialog.displayDialog("Error", context, "Error");
        editSceneStream.sink.add("Done");
        return false;
      } else {
        OpenDialog.displayDialog("Message", context, "Edit Success!!!");
        editSceneStream.sink.add("Done");
        return true;
      }
  }

  void dispose() {
    editSceneStream.close();
  }
}
