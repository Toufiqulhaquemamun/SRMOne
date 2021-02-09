import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loadingscreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Stream collectionStream = FirebaseFirestore.instance.collection('notes').snapshots();
  // Stream documentStream = FirebaseFirestore.instance.collection('notes').doc('ABC123').snapshots();

  getSnapshot () async{
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    notes.snapshots();
    print(notes.doc('year1').get());
  }

  getData() async{
    FirebaseFirestore.instance
        .collection('notes')
        .doc('year1')
        .collection('semester1')
        .doc('basic_engg')
        .collection('unit1')
        .doc('thermodynamics')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()['name']}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    getSnapshot ();
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: RaisedButton(
                child: Text(
                  'Launch PDF',

                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}







