import 'package:college_app/screens/loadingscreen.dart';
import 'package:college_app/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

class LoginPage extends StatelessWidget {
  String enteredEmail;
  String enteredPass;

  void loginAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: enteredEmail, password: enteredPass);
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
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    enteredEmail = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) {
                    enteredPass = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  splashColor: Colors.yellow[200],
                  animationDuration: Duration(seconds: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  child: Text('Login'),
                  onPressed: () async {
                    await loginAccount();
                    print("done");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("Don't have an account?"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                ),
              ],
            ),
          )
        ]));
  }
}
