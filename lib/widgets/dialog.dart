

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenDialog{
  static void displayDialog(title,context, error) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(error),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: new Text("OK"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}