import 'package:college_app/screens/bottomnavigation.dart';
import 'package:college_app/screens/contribute.dart';
import 'package:college_app/screens/loginpage.dart';
import 'package:college_app/screens/splashscreen.dart';
import 'package:college_app/services/usermanager.dart';
import 'package:flutter/material.dart';

enum AuthStatus{
  notloggedIn,
  loggedIn,
}

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  AuthStatus _authStatus = AuthStatus.notloggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentuser();
  }

  checkCurrentuser() async {
    String retVal = await AuthenticationService().onStartUp();

    if (retVal == 'success') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ContributeScreen()), (route) => false);
    }
  }

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
      return Center(child: CircularProgressIndicator());
  }
}
