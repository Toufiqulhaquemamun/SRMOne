import 'package:college_app/screens/bottomnavigation.dart';
import 'package:college_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {

  
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Error in Firebase Initilisation');
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Color(0xFF2604DE),
              accentColor:  Color(0xFFCB1841),
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Montserrat',

              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            title: 'College App',
            home: SplashScreen(),
            // initialRoute: '/login',
            // routes: {
            //   '/login': (context) => LoginScreen(),
            //   '/register': (context) => RegistrationScreen(),
            //   '/home': (context) => HomePage(),
            // },
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

