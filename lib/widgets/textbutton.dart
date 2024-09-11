import 'package:flutter/material.dart';
Widget textcolor({
  required t,
  required Color c,
  required Function() event
}){

  return TextButton(onPressed: event,
      child: Text(t,
        style: TextStyle(
            color: c,
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),
      ));
}

