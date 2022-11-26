import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/screen/chat_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final auth = FirebaseAuth.instance;
  bool visible = false;
  bool login = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // ignore: non_constant_identifier_names
  void Submit() async {
    UserCredential? user;
    var validate = _formkey.currentState!.validate();
      if (login == true) {
        await auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passController.text).then((value) => user = value
        ).onError((error, stackTrace) {
              showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Please Check Your Credentials'),));
              throw 'Login Failed';
        });
        if(user!=null){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()),);
          showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Login Successful'),actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('ok'))
          ],));
        }
      }
      else {
        auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text).then((value) =>
            FirebaseFirestore.instance.collection('people').doc(value.user!.uid).set({'email': value.user!.email})
        ).onError((error, stackTrace) {
          print(error);
          showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Please Correctly enter your details'),));
          throw "SignUp failed";
        });
      }

      print(user);

      if (validate) {
        _formkey.currentState!.save();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Card(margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _emailController,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text('email'),
                      suffixIcon: Icon(Icons.email),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  if(login == false)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value){
                        if(value!.isEmpty || value.length<4){
                          return 'Add a meaningful username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Username'),
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                  TextFormField(
                    controller: _passController,
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 6) {
                        return 'Please make a strong password';
                      }
                      return null;
                    },
                    obscureText: (visible == false) ? true : false,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      hintText: 'Enter Your Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: (visible == false)
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(key: ValueKey('login'),onPressed: Submit,
                      child: (login == true) ? Text('Login') : Text('SignUp')),
                  TextButton(key: ValueKey('Create'),onPressed: () {
                    setState(() {
                      login = !login;
                    });
                  },
                      child: (login == true)
                          ? Text('Create New Account')
                          : Text('I already have an account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//         body: Stack(
//           children: [
//           ClipPath(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.7,
//               //width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.elliptical(100, 100),
//
//                 ),
//                 gradient: const LinearGradient(
//                   colors: [Colors.purpleAccent, Colors.blueAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [0.4, 0.7],
//                 ),
//               ),
//             ),
//           ),
//   ]
//         )
//     );
//   }
// }
// class Clipper extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     Path path=Path();
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     throw UnimplementedError();
//   }
// }
//);
