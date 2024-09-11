import 'package:flutter/material.dart';
Widget btnCal ({
  required String text ,
  required Function() event ,
  Color c = Colors.grey ,
})
=> MaterialButton(
    shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25) ,
    ),
    onPressed: event,
    color: c ,
    child: Text(text,
        style: TextStyle(fontSize: 40)
    )
);