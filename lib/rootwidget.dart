import 'package:college_app/screens/bottomnavigation.dart';
import 'package:college_app/screens/signin.dart';
import 'package:college_app/services/usermanager.dart';
import 'package:flutter/material.dart';

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  AuthenticationService authenticationService = AuthenticationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCurrentuser();
  }

  checkCurrentuser() async {
    bool retVal = await authenticationService.checkIfUserIsSignedIn();
    if (retVal == true) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
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
