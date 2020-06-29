import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_task_planner_app/dataprovider/createtool.dart';

import 'package:flutter_task_planner_app/models/tool.dart';

class CreateToolBloc {
  StreamController createToolStream = new StreamController();
  Stream get createToolGet => createToolStream.stream;

  Future<bool> createTool(Tool tool, script) async {
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
        tool.image = value;
      });
    }
    var create = CreateTool();
    var result = await create.create(tool);
    print(result);
    if (!result) {
      createToolStream.sink.add("Error");
      return false;
    } else {
      createToolStream.sink.add("Create Success!!!");
      return true;
    }
  }

  void dispose() {
    createToolStream.close();
  }
}
