import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/chat/messages.dart';
import 'package:my_flutter_app/chat/new_message.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin{
  // late AnimationController controller;
  // late Animation animation;
  // @override
  // void initState() {
  //   super.initState();
  //   controller=AnimationController(
  //       duration: Duration(seconds: 2),
  //       vsync: this);
  //   animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
  //   controller.forward();
  //   animation.addStatusListener((status) {
  //     if(status==AnimationStatus.completed){
  //       controller.reverse(from: 1.0);
  //   }else if(status==AnimationStatus.dismissed){
  //       controller.forward();
  //     }
  //   });
  //   controller.addListener(() {
  //     setState(() {
  //       animation.value;
  //     });
  //   });
  // }
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.all(15),
              child: CircleAvatar(backgroundImage: AssetImage('assets/profile.png'),radius: 60),),
            Container(
              child: Image.asset('assets/welcome.png'),
              height: 100,
            ),
            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut();
              },
              child: ListTile(leading: Icon(Icons.logout,color: Colors.white),
                title: Text('LOGOUT',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                tileColor: Colors.red,),
            )
          ],
        ),

      ),
      appBar: AppBar(title: Text('Chats'),centerTitle: true,backgroundColor: Colors.green),
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
