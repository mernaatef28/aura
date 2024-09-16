import 'package:flutter/material.dart';

class TextformfeildWidget extends StatelessWidget {
  late TextEditingController Controller = TextEditingController();
  late String feildName  ;
  late Icon icon ;
   TextformfeildWidget({
     required this.Controller ,
     required this.feildName ,
     required this.icon ,


   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: Controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: feildName,
          suffixIcon: icon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $feildName';
          }
          return null;
        },
      ),
    ) ;
  }
}
