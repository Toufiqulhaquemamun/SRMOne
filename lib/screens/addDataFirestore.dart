import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
   String fullName;
   String company;
   int age;

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'full_name': fullName, // John Doe
        'username': company, // Stokes and Sons
        'year': age // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
              ),
              onChanged: (value){
                fullName = value;
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
              ),
              onChanged: (value){
                company = value;
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
              ),
              onChanged: (value){
                age = int.parse(value);
              },
            ),
            SizedBox(height: 20,),
            RaisedButton(
              child: Text(
                  'Submit Details'
              ),
              onPressed: ()async {
                await addUser();
                print("done");
              },
            ),
          ],
        ),
      );
    }
}