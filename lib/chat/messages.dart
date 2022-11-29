import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/chat/mesui.dart';
class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final auth=FirebaseAuth.instance;
  User ?cuser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try {
      final user = auth.currentUser;
      if (user != null) {
        cuser = user;
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy('messaged_on',descending: true).snapshots(),
      builder: (context,snaps){
        if(snaps.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents=snaps.data!.docs;
        final nowperson=cuser!.email;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx,index){
           final sender=documents[index]['email'];
            bool isMe= sender==nowperson;
            return Mesui(documents[index]['text'],isMe);
            },
        itemCount: documents.length,);
      },
    );
  }
}
