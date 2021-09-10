import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {

  final CollectionReference _userData =
      FirebaseFirestore.instance.collection('useruploads');

  Future<void> submitFileForReview(
      String? name, String? description, String uid, String? nameofuser, String? emailofuser) async {
    return await _userData.doc()
        .set({'name': name, 'description': description, 'uid': uid, 'nameofuser': nameofuser, 'emailofuser':emailofuser});
  }

  Future getAnnouncementList() async {
    List itemList = [];
    try {
      await FirebaseFirestore.instance.collection('announcements').get().then((QuerySnapshot querySnapshot) => {
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

  Future getSubjectList(int? semvalue) async {
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

  Future getUnitList(String? unit) async {
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
