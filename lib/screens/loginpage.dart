import 'package:college_app/screens/homepage.dart';
import 'package:college_app/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  String enteredEmail;
  String enteredPass;

  void loginAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
            ),
            onChanged: (value){
              enteredEmail = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
            ),
            onChanged: (value){
              enteredPass = value;
            },
          ),
          SizedBox(height: 20,),
          RaisedButton(
            child: Text(
                'Login'
            ),
            onPressed: ()async {
              await loginAccount();
              print("done");
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
            },
          ),
          SizedBox(height: 20,),
          RaisedButton(
            child: Text(
                "Don't have an account?"
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
            },
          ),
        ],
      ),
    );
  }
}
