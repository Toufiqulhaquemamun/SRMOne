import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future getPDFandUpload() async {
  //   FilePickerResult result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc'],
  //   );
  //
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //
  //     print(file.name);
  //     print(file.bytes);
  //     print(file.size);
  //     print(file.extension);
  //     print(file.path);
  //
  //     uploadFile(file);
  //   } else {
  //     Scaffold.of(context)
  //         .showSnackBar(SnackBar(content: Text("No file was selected")));
  //     return null;
  //   }
  // }

  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    print("File in function!");
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
        .child('playground')
        .child('/some-image.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);
    print("done..!");
    // uploadTask = ref.putFile(io.File(file.path), metadata);

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
          // PickedFile file =
          //     await ImagePicker().getImage(source: ImageSource.gallery);
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
