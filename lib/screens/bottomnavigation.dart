import 'package:college_app/rootwidget.dart';
import 'package:college_app/screens/homepage.dart';
import 'package:college_app/screens/contribute.dart';
import 'package:college_app/screens/navigation.dart';
import 'package:college_app/screens/submitpdf.dart';
import 'package:college_app/services/usermanager.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = "/bottom-navigation";
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
        'title': 'Home',
      },
      {
        'page': NavigationScreen(),
        'title': 'Explore',
      },
      {
        'page': SubmitScreen(),
        'title': 'Contribute',
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: ClipRRect(
        //   child: GestureDetector(
        //       child: Image(
        //         image: AssetImage("assets/images/profile.png"),
        //       ),
        //       onTap: () {
        //         Navigator.of(context).pushNamed(ProfilePage.routeName);
        //       }),
        // ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SRM Space',
              style: TextStyle(color: Colors.black),
            ),
            Visibility(
              visible: true,
              child: Text(
                'SRM University, Delhi NCR, Sonepat',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {
              //TODO: Setup Notifications
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () async {
              await AuthenticationService().signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RootWidget()), (route) => false);
            },
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurple,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text("Contribute"),
          ),
        ],
      ),
    );
  }
}