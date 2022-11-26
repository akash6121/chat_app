import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection(
            'chats/n96BpC1r5jHzDvFgfuvT/messages').snapshots(),
        builder: (context,snap){
          if(snap.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents=snap.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx,index)=>Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Press'),
        onPressed: () {
          FirebaseFirestore.instance.collection(
              'chats/n96BpC1r5jHzDvFgfuvT/messages').add({
            'text': 'Hi akash'
          });
          })
    );
        }
  }
