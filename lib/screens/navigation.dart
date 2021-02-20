import 'package:college_app/screens/loadingscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:college_app/services/databasemanger.dart';



class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<String> semesterList = ['Semester 1', 'Semester 2', 'Semester 3', 'Semester 4', 'Semester 5','Semester 6','Semester 7','Semester 8'];
  final List<Color> colors = [
    Color(0xffF19821),
    Color(0xff99BACB),
    Color(0xff498D7C),
    Color(0xff4E97F2),
    Color(0xffEFB958),
    Color(0xffB196C4),
    Color(0xffF49824),
    Color(0xffF95F35),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.deepPurple,
              expandedHeight: 20.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Explore",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                  background: Container(
                  )),
            ),
          ];
        },
        body: Container(
          color:Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                                child: Icon(Icons.search),
                              ),
                              Text('Notes, Question Papers, PDFs',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GridView.count(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio:
                          (MediaQuery.of(context).size.width / (2 * 100)),
                          children: List.generate(8, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  print(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SubjectView(index+1)));
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        shape: BoxShape.rectangle,
                                        color: colors[index]
                                      // gradient: new LinearGradient(
                                      //   colors: [
                                      //     Colors.blueAccent,
                                      //     Colors.red,
                                      //   ],
                                      //   begin: FractionalOffset.topLeft,
                                      //   end: FractionalOffset.bottomRight,
                                      // ),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                      child: Text(
                                        semesterList[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
