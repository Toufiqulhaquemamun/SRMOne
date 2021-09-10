import 'dart:async';

import 'package:college_app/services/databasemanger.dart';
import 'package:college_app/services/usermanager.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//This screen can be used to submit pdf notes

class SubmitScreen extends StatefulWidget {
  AuthenticationService authenticationService = AuthenticationService();
  DatabaseManager databaseManager = DatabaseManager();

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  User? user;
  String? nameoffile;
  String? description;

  final _formKey = GlobalKey<FormState>();

  Future<firebase_storage.UploadTask?> uploadFile(File file, String? name, String? des) async {
    user = widget.authenticationService.getCurrentUser();
    if (file == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to Upload")));
      return null;
    }
   await widget.databaseManager.submitFileForReview(name, des, user!.uid, user!.displayName,user!.email);
    firebase_storage.UploadTask uploadTask;
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('review')
        .child('/$name.pdf');

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
                  onPressed: () async {
                    final path = await (FlutterDocumentPicker.openDocument() as FutureOr<String>);
                    File file = File(path);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black
                                          ),
                                          onChanged: (value){
                                            nameoffile = value;
                                          },
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.attach_file),
                                            labelText: 'Name of the File',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black
                                          ),
                                          onChanged: (value){
                                            description = value;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Unit and Subject',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          child: Text("Submit"),
                                          onPressed: () async {
                                            firebase_storage.UploadTask? task = await uploadFile(file, nameoffile, description);
                                            if (_formKey.currentState!.validate()) {
                                              _formKey.currentState!.save();
                                            }
                                            Navigator.of(context).pop();
                                            final snackBar = SnackBar(
                                              content: Text('Your submission is under review. Thank you!'),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });

                    print("File uploaded!");
                  }
                ),
              ),
            ),
          ),
      SizedBox(height: 20.0,),
      Text(
        'Get started contributing!',
        style: TextStyle(fontFamily: 'Montserrat',
            color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
          Text(
            'Help us add notes to the app.',
            style: TextStyle(fontFamily: 'Montserrat',
              color: Colors.black,
                fontSize: 15.0
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Theme.of(context).primaryColor ,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed:() async {

          final path = await (FlutterDocumentPicker.openDocument() as FutureOr<String>);
          File file = File(path);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black
                                ),
                                onChanged: (value){
                                  nameoffile = value;
                                },
                                decoration: InputDecoration(

                                  icon: Icon(Icons.attach_file),
                                  labelText: 'Name of the File',
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black
                                ),

                                onChanged: (value){
                                  description = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Unit and Subject',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () async {
                                  firebase_storage.UploadTask? task = await uploadFile(file, nameoffile, description);
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                  Navigator.of(context).pop();
                                  final snackBar = SnackBar(
                                    content: Text('Your submission is under review. Thank you!'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });

          print("File uploaded!");
        }
      ),
    );
  }
}

