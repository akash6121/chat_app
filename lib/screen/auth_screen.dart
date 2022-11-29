import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;
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
          debugPrint(error.toString());
              showDialog(context: context, builder: (context)=>const AlertDialog(title: Text('Please Check Your Credentials'),));
              throw 'Login Failed';
        });
        if(user!=null){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen()),);
          showDialog(context: context, builder: (context)=>AlertDialog(title: const Text('Login Successful'),actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text('ok'))
          ],));
        }
      }
      else {
        auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text).then((value) =>
            FirebaseFirestore.instance.collection('people').doc(value.user!.uid).set({'email': value.user!.email})
        ).onError((error, stackTrace) {
          //print(error);
          showDialog(context: context, builder: (context)=>const AlertDialog(title: Text('Please Correctly enter your details'),));
          throw "SignUp failed";
        });
      }

      //print(user);

      if (validate) {
        _formkey.currentState!.save();
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this);
    animation=ColorTween(begin: Colors.red,end: Colors.yellow).animate(controller);
    controller.forward();
    controller.addListener(() {
      print(controller.value);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Stack(
        children: [
          ClipPath(
            clipper: Clipper(),
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.1),
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.4, 0.7],
                ),
              ),
              child: Column(
                children: [
                  Text('LOGIN',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40)),
               Hero(
                 tag: 'logo',
                   child: CircleAvatar(backgroundImage: AssetImage('assets/profile.png'),radius: 80,)),
                ],
              ),
            ),
          ),
          Center(
            child: Card(margin: const EdgeInsets.all(20),
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
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text('email'),
                        suffixIcon: Icon(Icons.email),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    if(login == false)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value){
                          if(value!.isEmpty || value.length<4){
                            return 'Add a meaningful username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Username'),
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                    TextFormField(
                      controller: _passController,
                      key: const ValueKey('password'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return 'Please make a strong password';
                        }
                        return null;
                      },
                      obscureText: (visible == false) ? true : false,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintText: 'Enter Your Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: (visible == false)
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(key: const ValueKey('login'),onPressed: Submit,
                        child: (login == true) ? const Text('Login') : const Text('SignUp')),
                    TextButton(key: const ValueKey('Create'),onPressed: () {
                      setState(() {
                        login = !login;
                      });
                    },
                        child: (login == true)
                            ? const Text('Create New Account')
                            : const Text('I already have an account'))
                  ],
                ),
              ),
            ),
        ),
          ),
      ]),
    );
  }
}


//         body: Stack(
//           children: [
//           ClipPath(
//             child:
//            ),
// //   ]
//         )
//     );
//   }
// }
class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height*0.2);
     path.lineTo(0, size.height-50);
    // path.lineTo(size.width, size.height);
     path.quadraticBezierTo(size.width*0.5, size.height-100, size.width, size.height);
     path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
