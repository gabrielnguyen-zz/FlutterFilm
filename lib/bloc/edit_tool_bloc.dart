import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/edittool.dart';
import 'package:flutter_task_planner_app/models/tool.dart';

class EditToolBloc {
  StreamController editToolStream = new StreamController();
  Stream get editToolGet => editToolStream.stream;

  Future<bool> editTool(Tool tool,script) async {
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
     var edit = EditTool();
      var result = await edit.editTool(tool);
      print(result);
      if (!result) {
        editToolStream.sink.add("Error");
        return false;
      } else {
        editToolStream.sink.add("Success!!!");
        return true;
      }
  }

  void dispose() {
    editToolStream.close();
  }
}