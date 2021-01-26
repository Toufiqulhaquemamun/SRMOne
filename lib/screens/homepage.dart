import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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
        .ref('notes/Service_Agreement-VERGE.pdf')
        .getDownloadURL();
    print(downloadURL);
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
    return Center(child: CircularProgressIndicator());
  }
}
