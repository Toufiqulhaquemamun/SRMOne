import 'package:college_app/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  String enteredEmail;
  String enteredPass;
  String fullName;
  String regnno;
  int year;

  void createAccount() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'full_name': fullName,
        'registrationnumber': regnno,
        'year': year
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Email'
            ),
            onChanged: (value){
              enteredEmail = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                hintText: 'Password'
            ),
            onChanged: (value){
              enteredPass = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                hintText: 'Name'
            ),
            onChanged: (value){
              fullName = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
                hintText: 'Regn No'
            ),
            onChanged: (value){
              regnno = value;
            },
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
            ),
            onChanged: (value){
              year = int.parse(value);
            },
          ),
          SizedBox(height: 20,),
          RaisedButton(
            child: Text(
                'Submit Details'
            ),
            onPressed: ()async {
              await createAccount();
              await addUser();
              print("done");
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
