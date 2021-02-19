import 'package:college_app/screens/navigation.dart';
import 'package:college_app/screens/notes.dart';
import 'package:college_app/screens/submitpdf.dart';
import 'package:college_app/services/databasemanger.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List announcementList = [];
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    isLoaded = false;
    fetchDataList();
  }

  fetchDataList() async {
    dynamic resultant = await DatabaseManager().getAnnouncementList();
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        isLoaded = true;
        announcementList = resultant;
        print(announcementList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Upcoming Events',
                          style: TextStyle(
                            fontSize: 20.0,
                            // fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'See whats happening on Campus',
                          style: TextStyle(
                            fontSize: 15.0,
                            // fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              /* Search Button */
            ],
          ),
        ),
      ),
    );
  }
}
