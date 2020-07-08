import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/createactor.dart';
import 'package:flutter_task_planner_app/models/actor.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class CreateActorBloc {
  StreamController createActorStream = new StreamController();
  Stream get createActorGet => createActorStream.stream;

  Future<bool> createActor(context, Actor actor, script) async {
    createActorStream.sink.add("Logging");
    if (script != null && script.filename != null) {
      print('start upload');
      var filename = script.filename +
          "-" +
          DateTime.now().toString() +
          "." +
          script.fileExtension;
      print(script.file);
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('Actor/' + filename);
      print(storageReference.path);
      StorageUploadTask uploadTask = storageReference.putFile(script.file);
      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        print('EVENT ${event.type}');
      });

      await uploadTask.onComplete;

      await storageReference.getDownloadURL().then((value) {
        print(value);
        actor.image = value;
      });
      var create = CreateActor();
      var result = await create.create(actor);
      print(result);
      if (!result) {
        OpenDialog.displayDialog("Error", context, "Error");
        createActorStream.sink.add("Done");

        return false;
      } else {
        OpenDialog.displayDialog("Message", context, "Add Success!!!");
        createActorStream.sink.add("Done");

        return true;
      }
    } else {
      createActorStream.sink.add("Done");
      OpenDialog.displayDialog("Error", context, "Add Picture");
      return false;
    }
  }

  void dispose() {
    createActorStream.close();
  }
}
