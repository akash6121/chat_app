import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/chat/messages.dart';
import 'package:my_flutter_app/chat/new_message.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: IconButton(icon: Icon(Icons.logout,size: 40,color: Colors.red),onPressed: (){
          FirebaseAuth.instance.signOut();
        },),
      ),
      appBar: AppBar(title: Text('Chats'),centerTitle: true,backgroundColor: Colors.green,),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
        }
  }
