import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_task_planner_app/dataprovider/createtool.dart';

import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class CreateToolBloc {
  StreamController createToolStream = new StreamController();
  Stream get createToolGet => createToolStream.stream;

  Future<bool> createTool(context, Tool tool, script) async {
    createToolStream.sink.add("Logging");
    if (script != null && script.filename != null) {
      print('start upload');
      var filename = script.filename +
          "-" +
          DateTime.now().toString() +
          "." +
          script.fileExtension;
      print(filename);
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('Tool/' + filename);

      StorageUploadTask uploadTask = storageReference.putFile(script.file);

      await uploadTask.onComplete;

      print('Uploaded');

      await storageReference.getDownloadURL().then((value) {
        print(value);
        tool.image = value;
      });
      var create = CreateTool();
      var result = await create.create(tool);
      print(result);
      if (!result) {
    OpenDialog.displayDialog("Error", context, "Error");
        createToolStream.sink.add("Done");
        return false;
      } else {
    OpenDialog.displayDialog("Message", context, "Add Success !!!");
        createToolStream.sink.add("Done");
        return true;
      }
    }
    OpenDialog.displayDialog("Error", context, "Add Picture");
    createToolStream.sink.add("Done");
    return false;
  }

  void dispose() {
    createToolStream.close();
  }
}
