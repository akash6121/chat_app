import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/chat/mesui.dart';
class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

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
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx,index)=>Mesui(documents[index]['text']),
        itemCount: documents.length,);
      },
    );
  }
}
