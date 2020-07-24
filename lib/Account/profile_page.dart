import 'dart:convert';

import 'package:ayodolan/Account/profile_photo.dart';
import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  // Future chooseImage() async {
  //   setState(() {
  //     final file = await ImagePicker.getImage(source: ImageSource.gallery);
  //   });
  //   setStatus('');
  // }
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    if (picked != null) {
      selectedDate = picked;
      inputBorn.text = _formatdate(picked);
    }
  }

  Widget _showImage(photo) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: new NetworkImage(photo),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
      ),
    );
  }

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
      return res.body;
      // var body = json.decode(res.body.toString());
      // print(body);

    } else {
      throw Exception('Failed to load internet');
    }
  }

  _setData(item) {
    inputName.text = item['name'].toString();
    inputEmail.text = item['email'].toString();
    inputPhone.text =
        item['phone'].toString() == null ? '-' : item['phone'].toString();
    inputAddress.text = item['address'].toString();
    inputBorn.text = item['born'].toString();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   this.getJSONData();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJSONData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            dynamic response = json.decode(snapshot.data.toString())['data'];
            print(response['photo']);
            _setData(response);
            return SingleChildScrollView(
              child: Card(
                  margin: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        _showImage(response['photo']),
                        Center(
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profilPhoto()));
                              },
                              child: Text(
                                "Ganti Foto Saya",
                                style: TextStyle(
                                    color: PrimaryColor, fontSize: 18.0),
                              )),
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: inputPhone,
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              hintText: "No telp...",
                              hintStyle: TextStyle(color: PrimaryColor)),
                        ),
                        TextField(
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
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
                                color: _isLoading ? Colors.grey : PrimaryColor,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: _updateUser,
                                child: Text(
                                  _isLoading ? "Proses..." : "Simpan",
                                  style: TextStyle(fontSize: 20.0),
                                )),
                            FlatButton(
                                color: Colors.grey,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: () {
                                  _isLoading
                                      ? print('loading..')
                                      : _reloadData();
                                },
                                child: Text(
                                  _isLoading ? "Loading..." : "Refresh",
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
                  )),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Mohon tunggu...'),
                  )
                ],
              ),
            );
          }
        });
  }

  Future<void> _updateUser() async {
    if (_isLoading) {
      print('Masih Proses...');
      return false;
    }

    setState(() {
      _isLoading = true;
    });
    var datarow = {
      'name': inputName.text,
      'email': inputEmail.text,
      'phone': inputPhone.text,
      'address': inputAddress.text,
      'born': inputBorn.text
    };

    var res = await CallApi().postDataAuth(datarow, 'user-update');

    print(res.statusCode);

    if (res.statusCode == 200) {
      var body = json.decode(res.body.toString());
      if (body['status']) {
        _showMsg(body['message']);
      } else {
        _showMsg(body['message']);
      }
    } else {
      throw Exception('Failed to load internet');
    }
    setState(() {
      _isLoading = false;
    });
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

  void _reloadData() {
    setState(() {
      _isLoading = true;
    });

    print(_isLoading);

    getJSONData();

    setState(() {
      _isLoading = false;
    });
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

  String _formatdate(tdate) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(tdate);
    return formattedDate;
  }
}
