import 'dart:convert';

import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/Page/home.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Invoice extends StatefulWidget {
  String transkasiId;
  Invoice({Key key, @required this.transkasiId}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  dynamic data;
  bool isData = false;

  //Function to get the json
  Future<void> getJSONData(String id) async {
    var res = await CallApi().getDataAuth('invoice/' + id);
    var body = json.decode(res.body.toString());
    print(body);
    setState(() {
      // Get the JSON data
      data = body['data'];
      isData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData(widget.transkasiId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 1.0,
          title: Text("Invoice"),
          automaticallyImplyLeading: false),
      body: Container(
        child: Column(
          children: <Widget>[_info(), _help()],
        ),
      ),
    );
  }

  Widget _help() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Catatan',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: PrimaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                  'Silahkan melakukan pembayaran ke No Rek xxxxxxxx lalu lakukan konfirmasi',
                  style: TextStyle(fontSize: 16.0, color: PrimaryColor))
            ],
          )),
    );
  }

  Widget _info() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('No Invoice:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    isData ? data['nomor_invoice'].toString() : 'Loading...',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    isData ? data['total_transaksi'].toString() : 'Loading...',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    isData ? data['status'].toString() : 'Loading...',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  color: PrimaryColor,
                  child: const Text('Konfirmasi Pembayaran',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _launchURL();
                  },
                ),
                FlatButton(
                  color: PrimaryColor,
                  child: const Text('Kembali Ke Awal',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
