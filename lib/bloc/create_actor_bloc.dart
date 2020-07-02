import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/createactor.dart';
import 'package:flutter_task_planner_app/models/actor.dart';

class CreateActorBloc {
  StreamController createActorStream = new StreamController();
  Stream get createActorGet => createActorStream.stream;

  Future<bool> createActor(Actor actor, script) async {
    if (script != null) {
      if (script != null && script.filename != null) {
        print('start upload');
        var filename = script.filename +
            "-" +
            DateTime.now().toString() +
            "." +
            script.fileExtension;
        print(filename);
        StorageReference storageReference =
            FirebaseStorage.instance.ref().child('Actor/' + filename);

        StorageUploadTask uploadTask = storageReference.putFile(script.file);

        await uploadTask.onComplete;

        print('Uploaded');

        await storageReference.getDownloadURL().then((value) {
          print(value);
          actor.image = value;
        });
        var create = CreateActor();
        var result = await create.create(actor);
        print(result);
        if (!result) {
          createActorStream.sink.add("Error");
          return false;
        } else {
          createActorStream.sink.add("Create Success!!!");
          return true;
        }
      } else {
        createActorStream.sink.add("Add Picture!!!");
        return false;
      }
    }
  }

  void dispose() {
    createActorStream.close();
  }
}
