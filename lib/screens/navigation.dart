
import 'package:flutter/material.dart';
import 'package:college_app/services/databasemanger.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List semesterList = [];
  int sem;

  @override
  void initState() {
    super.initState();
    fetchDataList();
  }

  fetchDataList() async {
    dynamic resultant = await DatabaseManager().getSemList();

    if(resultant == null){
      print("Unable to retrieve");
    }

    else {
      setState(() {
        semesterList = resultant;
        print(semesterList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: semesterList.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SubjectView(semesterList[index]['value']) ));
              },
              child: Card(
                child: ListTile(
                  title: Text(semesterList[index]['name']),
                  // subtitle: Text(semesterList[index]['teacher']),
                  // trailing: Text('${semesterList[index]['rating']}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



class SubjectView extends StatefulWidget {
  int semValue;
  SubjectView(this.semValue);
  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  List subjectList = [];
  int sem;

  @override
  void initState() {
    super.initState();
    sem = widget.semValue;
    fetchDataList();
  }

  fetchDataList() async {
    dynamic resultant = await DatabaseManager().getSubjectList(sem);
    print(sem);

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
                  // subtitle: Text(semesterList[index]['teacher']),
                  // trailing: Text('${semesterList[index]['rating']}'),
                ),
              );
          },
        ),
      ),
    );
  }
}


