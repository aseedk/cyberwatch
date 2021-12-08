import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Backend/flutter_fire.dart';
import 'Backend/facebook.dart';
import 'Backend/twitter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _initialized = false;
  bool _error = false;
  int _counter = 0;
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_error) {
      print('Error');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('Loading');
    }

    print('Firebase Loaded');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: (){},
              child: const Text('Register'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: (){},
              child: const Text('Login'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: signInWithGoogle,
              child: const Text('Login Google'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: loginTwitter,
              child: const Text('Login Twitter'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: loginFacebook,
              child: const Text('Login Facebook'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: checkUserFacebook,
              child: const Text('Check Facebook'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: (){
                getUserDataFacebook();
                getUserPhotosFacebook();
                getUserVideosFacebook();
                getUserPostsFacebook();
              },
              child: const Text('Get User Facebook'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: logoutUser,
              child: const Text('logout'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: getUserTweets,
              child: const Text('Get User Twitter'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}