import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//This screen can be used to submit pdf notes

class SubmitScreen extends StatefulWidget {
  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    if (file == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to Upload")));
      return null;
    }
    var rng = Random();
    String randomName = " ";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    firebase_storage.UploadTask uploadTask;
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('review')
        .child('/$randomName.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);
    // uploadTask = ref.putFile(io.File(file.path), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Check Firebase and PDF"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          print("Looking for file!");
          final path = await FlutterDocumentPicker.openDocument();
          print(path);
          File file = File(path);
          firebase_storage.UploadTask task = await uploadFile(file);
          print("File uploaded!");
          if (task != null) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Uploaded")));
          }
        },
      ),
    );
  }
}
