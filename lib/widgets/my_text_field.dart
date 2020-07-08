import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  final String hint;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String error;
  MyTextField({this.label, this.maxLines = 1, this.minLines = 1, this.icon,this.controller,this.hint,this.keyboard,this.error});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboard,
      validator: (value){
        return error;
      },
      decoration: InputDecoration(
        suffixIcon: icon == null ? null: icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
