import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Frontend/splash.dart';
import 'Frontend/error.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Error',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const ErrorView(),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("Firebase Loaded");
          return MaterialApp(
            title: 'Cyber Watch',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashView(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title: 'Cyber Watch',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashView(),
        );
      },
    );
  }
}