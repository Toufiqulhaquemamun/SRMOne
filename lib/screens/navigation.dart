import 'package:college_app/services/usermanager.dart';
import 'package:flutter/material.dart';
import 'package:college_app/services/databasemanger.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List subjectList = [];
  int sem;

  @override
  void initState() {
    super.initState();
    fetchDataList();
  }

  fetchDataList() async {
    dynamic resultant = await DatabaseManager().getSubjectList();

    if(resultant == null){
      print("Unable to retrieve");
    }
    else {
      setState(() {
        subjectList = resultant;
        print(subjectList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: subjectList.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(subjectList[index]['name']),
                subtitle: Text(subjectList[index]['teacher']),
                trailing: Text('${subjectList[index]['rating']}'),
              ),
            );
          },
        ),

      ),
    );
  }
}

