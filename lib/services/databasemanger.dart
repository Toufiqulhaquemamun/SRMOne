import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager  {
  // int semester;
  // DatabaseManager(this.semester);

  final CollectionReference subjectList =
  FirebaseFirestore.instance.collection('semester1');


  Future<void> createSubjectData(
      String name, String gender, int score, String uid) async {
    return await subjectList
        .doc(uid)
        .set({'name': name, 'gender': gender, 'score': score});
  }

  Future getSubjectList() async {
    List itemList = [];
    try {
      await subjectList.get().then((QuerySnapshot querySnapshot) => {
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
