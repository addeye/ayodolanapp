import 'dart:convert';

import 'package:ayodolan/Login/loginScreen.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Center(
          child: FlatButton(
              color: Colors.orange,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: exitApp,
              child: Text(
                "Keluar",
                style: TextStyle(fontSize: 20.0),
              )),
        ),
      ],
    ));
  }

  exitApp() {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Peringatan!'),
        content: Text('Apakah anda yakin keluar?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text('Tidak'),
          ),
          FlatButton(
            // onPressed: () {
            //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            // },
            onPressed: _logout,
            child: Text(_isLoading ? 'Loading...' : 'Oke'),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    setState(() {
      _isLoading = true;
    });

    var data = [];

    var res = await CallApi().postDataAuth(data, 'logout');
    var body = json.decode(res.body.toString());
    print(body);
    if (body['status']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', '');
      localStorage.setString('user', '');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LogIn()));
    } else {
      _showMsg(body['message']);
    }
  }
}
