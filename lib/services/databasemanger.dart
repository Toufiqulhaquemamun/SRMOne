import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager  {
  // int semester;
  // DatabaseManager(this.semester);

  final CollectionReference getSemData =
  FirebaseFirestore.instance.collection('notes');

  CollectionReference getSubjectData;


  // Future<void> createSubjectData(
  //     String name, String teacher, int rating, String uid) async {
  //   return await getSemData
  //       .doc(uid)
  //       .set({'name': name, 'teacher': teacher, 'rating': rating});
  // }

  Future getSemList() async {
    List itemList = [];
    try {
      await getSemData.get().then((QuerySnapshot querySnapshot) => {
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

  Future getSubjectList(int semvalue) async {
    if (semvalue == 1){
      getSubjectData  =
          FirebaseFirestore.instance.collection('notes').doc('year1').collection('semester1');
    }else{
      getSubjectData  =
          FirebaseFirestore.instance.collection('notes').doc('year2').collection('semester3');
    }
    List itemList = [];
    try {
      await getSubjectData.get().then((QuerySnapshot querySnapshot) => {
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
