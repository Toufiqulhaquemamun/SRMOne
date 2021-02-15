import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  // int semester;
  // DatabaseManager(this.semester);


  final CollectionReference _userData =
      FirebaseFirestore.instance.collection('user');

  Future<void> createUserData(
      String name, String gender, int rating, String uid) async {
    return await _userData
        .doc(uid)
        .set({'name': name, 'gender': gender, 'rating': rating});
  }

  // Future<void> createSubjectData(
  //     String name, String teacher, int rating, String uid) async {
  //   return await getSemData
  //       .doc(uid)
  //       .set({'name': name, 'teacher': teacher, 'rating': rating});
  // }
  // final CollectionReference getSemData =
  //     FirebaseFirestore.instance.collection('notes');

  // Future getSemList() async {
  //   List itemList = [];
  //   try {
  //     await getSemData.get().then((QuerySnapshot querySnapshot) => {
  //           querySnapshot.docs.forEach((doc) {
  //             itemList.add(doc.data());
  //           }),
  //         });
  //     return itemList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future getSubjectList(int semvalue) async {
    List itemList = [];
    try {
      await FirebaseFirestore.instance.collection('subjects').where("semvalue", isEqualTo: semvalue).get().then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              itemList.add(doc.data());
            }),
          });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUnitList(String unit) async {
    List itemList = [];
    try {
      await FirebaseFirestore.instance.collection('units').where('unit', isEqualTo: unit).get().then((QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach((doc) {
              itemList.add(doc.data());
            }),
          });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
