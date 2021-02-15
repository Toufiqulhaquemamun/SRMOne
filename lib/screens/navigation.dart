import 'package:college_app/screens/loadingscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_app/services/databasemanger.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
        ),
        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectView(1)));
                  },
                  child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        'Semester 1',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectView(1)));
                  },
                  child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        'Semester 1',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectView(1)));
                  },
                  child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        'Semester 1',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectView(1)));
                  },
                  child: Container(
                    height: 180.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(color: Colors.black)),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        'Semester 1',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
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

    if (resultant == null) {
      print("Unable to retrieve");
    } else {
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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UnitView(subjectList[index]['unit'])));
              },
              child: Card(
                child: ListTile(
                  title: Text(subjectList[index]['name']),
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

class UnitView extends StatefulWidget {
  String unitname;
  UnitView(this.unitname);
  @override
  _UnitViewState createState() => _UnitViewState();
}

class _UnitViewState extends State<UnitView> {
  List subjectList = [];
  String unit;

  @override
  void initState() {
    super.initState();
    unit = widget.unitname;
    print(unit);
    fetchDataList();
  }

  fetchDataList() async {
    dynamic resultant = await DatabaseManager().getUnitList(unit);
    print(unit);
    print(resultant);

    if (resultant == null) {
      print("Unable to retrieve");
    } else {
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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoadingScreen(subjectList[index]['url'])));
              },
              child: Card(
                child: ListTile(
                  title: Text(subjectList[index]['name']),
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
