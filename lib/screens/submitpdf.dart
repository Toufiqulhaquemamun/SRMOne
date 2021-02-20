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

   void _selectFile() async{
    final path = await FlutterDocumentPicker.openDocument();
    File file = File(path);
    firebase_storage.UploadTask task = await uploadFile(file);
    print("File uploaded!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height: 180.0,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Colors.black)),
                width: MediaQuery.of(context).size.width * 0.8,
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 50.0,
                  ),
                  onPressed: _selectFile
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _selectFile
      ),
    );
  }
}

class AddMoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

