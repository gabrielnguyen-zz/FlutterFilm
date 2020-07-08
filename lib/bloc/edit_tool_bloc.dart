import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_planner_app/dataprovider/edittool.dart';
import 'package:flutter_task_planner_app/models/tool.dart';
import 'package:flutter_task_planner_app/widgets/dialog.dart';

class EditToolBloc {
  StreamController editToolStream = new StreamController();
  Stream get editToolGet => editToolStream.stream;

  Future<bool> editTool(context,Tool tool, script, image) async {
    editToolStream.sink.add("Logging");
    if (image == null) {
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
    }else{
      tool.image = image;
    }

    var edit = EditTool();
    var result = await edit.editTool(tool);
    print(result);
    if (!result) {
      OpenDialog.displayDialog("Error", context, "Error");
      editToolStream.sink.add("Done");
      return false;
    } else {
      OpenDialog.displayDialog("Message", context, "Edit Complete!!!");
      editToolStream.sink.add("Done");
      return true;
    }
  }

  void dispose() {
    editToolStream.close();
  }
}
