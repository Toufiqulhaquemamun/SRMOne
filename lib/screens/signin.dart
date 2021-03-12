import 'package:flutter/material.dart';
import 'package:college_app/services/usermanager.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(50),
            child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      await authenticationService.onGoogleSignIn(context);
                    },
                    // color: isUserSignedIn ? Colors.green : Colors.blueAccent,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                                // isUserSignedIn ? 'You\'re logged in with Google' :
                                'Login with Google',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',fontWeight: FontWeight.bold))
                          ],
                        )
                    )
                )
            )
        )
    );
  }
}
