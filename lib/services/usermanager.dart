//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserManger  {
//   final CollectionReference subjectList = FirebaseFirestore.instance.collection('user');
//
//   Future<void> addUser(
//       String name, String gender, int score, String uid) async {
//     return await subjectList
//         .doc(uid)
//         .set({'name': name, 'gender': gender, 'score': score});
//   }
//
//   Future getUserSemester() async {
//     int semester;
//     try {
//       await subjectList.get().then((QuerySnapshot querySnapshot) => {
//         querySnapshot.docs.forEach((doc) {
//           semester = int.parse(doc.data()['semester']);
//         }),
//       });
//       return semester;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }