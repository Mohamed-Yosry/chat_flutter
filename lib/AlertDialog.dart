import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  Model model;
  AppAlertDialog(this.model);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(model.content),
      title: Text(model.title,style: TextStyle(fontWeight:FontWeight.bold),),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(onPressed: model.yesOnpressed, child: Text("Yes")),
        // ignore: deprecated_member_use
        FlatButton(onPressed: model.noOnPressed, child: Text("No")),
      ],
    );
  }
}


class Model{
  String content;
  String title;
  var yesOnpressed;
  var noOnPressed;

  Model(this.content,this.title,this.noOnPressed,this.yesOnpressed);
}