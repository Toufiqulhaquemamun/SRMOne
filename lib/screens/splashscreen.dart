import 'dart:async';
import 'package:college_app/rootwidget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => RootWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCB1841),
              Color(0xFF2604DE)
            ]
          ),
        ),
        child: Center(
          child: Text(
            'SRM One',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0
            ),
          ),
        ),
      ),
    );
  }
}