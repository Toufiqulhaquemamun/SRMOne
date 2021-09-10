import 'package:college_app/screens/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeUser extends StatefulWidget {
  User? _user;

  WelcomeUser(User? user) {
    _user = user;
  }

  @override
  _WelcomeUserState createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {


  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (ctx) => BottomNavigationScreen(),
    ), (route) => false);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
          ),
          body: Container(
              color: Colors.white,
              padding: EdgeInsets.all(50),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                          child: Image.network(
                              widget._user!.photoURL!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover
                          )
                      ),
                      SizedBox(height: 20),
                      Text('Welcome,',style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Montserrat',
                      ), textAlign: TextAlign.center),
                      Text(
                          widget._user!.displayName!, textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(height: 20),
                      Center(child: CircularProgressIndicator())
                    ],
                  )
              )
          )
      );
    }
  }
