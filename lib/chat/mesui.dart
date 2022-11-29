import 'package:flutter/material.dart';
class Mesui extends StatelessWidget {
   Mesui(this.message,this.user);
  final String message;
  final bool user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: user?CrossAxisAlignment.end:CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(color: user?Colors.green:Colors.grey,borderRadius: BorderRadius.circular(20)),
          child: Text(message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}
