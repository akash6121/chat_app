import 'package:flutter/material.dart';
class Mesui extends StatelessWidget {
   Mesui(this.message);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
          child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}
