import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:college_app/services/databasemanger.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// registration with email and password

  Future createNewUser(String name, String email, String password, String regnno) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseManager().createUserData(name, email, regnno, user.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> onStartUp() async {
    String retVal = 'error';
    try{
      User _firebaseUser = await _auth.currentUser;
      var _uid = _firebaseUser.uid;
      var _email = _firebaseUser.email;
      retVal = 'success';
    }
    catch(e){
    }
    return retVal;
  }

// sign with email and password

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

// signout
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
