import 'dart:convert';

import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/Login/loginScreen.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  dynamic data;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputAddress = TextEditingController();
  TextEditingController inputBorn = TextEditingController();

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

  //Function to get the json
  Future<void> getJSONData() async {
    var res = await CallApi().getDataAuth('user-active');

    print(res.statusCode);

    if (res.statusCode == 200) {
      var body = json.decode(res.body.toString());
      print(body);
      setState(() {
        // Get the JSON data
        data = body['data'];
        _setData(data);
      });
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<void> _setData(item) async {
    inputName.text = item['name'].toString();
    inputEmail.text = item['email'].toString();
    inputPhone.text =
        item['phone'].toString() == null ? '-' : item['phone'].toString();
    inputAddress.text = item['address'].toString();
    inputBorn.text = item['born'].toString();
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: new NetworkImage(data['photo']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(100.0)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: inputName,
                decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: "Nama lengkap...",
                    hintStyle: TextStyle(color: PrimaryColor)),
              ),
              TextField(
                controller: inputEmail,
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "Alamat email...",
                    hintStyle: TextStyle(color: PrimaryColor)),
              ),
              TextField(
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: inputPhone,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "No telp...",
                    hintStyle: TextStyle(color: PrimaryColor)),
              ),
              TextField(
                controller: inputBorn,
                decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    hintText: "Tanggal Lahir...",
                    hintStyle: TextStyle(color: PrimaryColor)),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 41.0),
                  child: TextField(
                    controller: inputAddress,
                    maxLines: 2,
                    decoration: InputDecoration(
                        icon: null,
                        hintText: "Alamat...",
                        hintStyle: TextStyle(color: PrimaryColor)),
                  )),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      color: PrimaryColor,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: _updateUser,
                      child: Text(
                        "Simpan",
                        style: TextStyle(fontSize: 20.0),
                      )),
                  FlatButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: exitApp,
                      child: Text(
                        "Keluar",
                        style: TextStyle(fontSize: 20.0),
                      ))
                ],
              )
            ],
          ),
        ));
  }

  _updateUser() {
    print("Update user ayodolan!");
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
            onPressed: _isLoading ? null : _logout,
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
      Navigator.pushNamed(context, '/login');
      // Navigator.pop(context,
      //     MaterialPageRoute(builder: (BuildContext context) => LogIn()));
    } else {
      _showMsg(body['message']);
    }
  }
}
