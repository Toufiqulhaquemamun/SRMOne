import 'dart:io';
import 'package:college_app/screens/notes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //     .ref()
  //     .child('notes')
  //     .child('Service_Agreement-VERGE.pdf');

  Future<void> listExample() async {
    firebase_storage.ListResult result =
    await firebase_storage.FirebaseStorage.instance.ref().child('notes').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
  }

  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('notes/year1/basic_engg/unit1/Basic Unit 1 Part 2.pdf')
        .getDownloadURL();
    print(downloadURL);
    PDFDocument doc = await PDFDocument.fromURL(downloadURL);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesPage(doc)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Fetching files");
    listExample();
    print("Getting URL");
    downloadURLExample();
    print("All done!");
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
      ),
    );
  }
}

