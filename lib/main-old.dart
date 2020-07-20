import 'package:ayodolan/Page/home.dart';
import 'package:ayodolan/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print('ini token $token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    print('is login $_isLoggedIn');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _isLoggedIn == true ? HomePage() : LogIn(),
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(title: 'home'),
        '/login': (BuildContext context) => LogIn(title: 'login'),
      },
      // initialRoute: '/',
    );
  }
}
