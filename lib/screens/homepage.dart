import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

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
                child: GestureDetector(
                  onTap: (){
                    _launchURL('https://adityathakurxd.medium.com/srm-one-314f8691b18b');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                          colors: [Color(0xFFCB1841), Color(0xFF2604DE)],
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
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'This app is still under development.',
                            style: TextStyle(  fontFamily: 'Montserrat',
                              fontSize: 15.0,
                              // fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: (){
                    _launchURL('https://github.com/AV-Studios/college-app');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                          colors: [Colors.deepOrangeAccent, Colors.orange],
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
                            'GitHub Repository',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Check out latest issues and features!',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
