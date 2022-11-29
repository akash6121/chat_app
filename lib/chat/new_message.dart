import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController _msgcontrol = new TextEditingController();
  String?enteredtext;
  void sendMessage()async{
    FocusScope.of(context).unfocus();
    final user=await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredtext,
      'messaged_on' : Timestamp.now(),
      'email' : user!.email,
    });
    _msgcontrol.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(keyboardType: TextInputType.multiline,
              controller: _msgcontrol,
              decoration: InputDecoration(labelText: 'Send a message'),
            onChanged: (val){
              setState(() {
                 enteredtext=val;
              });
            },),
          ),
          IconButton(
            icon: Icon(Icons.send),color: Colors.green,
            onPressed: (){
            enteredtext!.trim().isEmpty ? null : sendMessage();
          },),
        ],
      ),
    );
  }
}
