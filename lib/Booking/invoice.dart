import 'dart:convert';

import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  String transkasiId;
  Invoice({Key key, @required this.transkasiId}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  dynamic data;
  String id;

  @override
  void initState() {
    super.initState();
    this.id = widget.transkasiId;
  }

  //Function to get the json
  Future<void> getJSONData() async {
    var res = await CallApi().getDataAuth('invoice/' + id);
    var body = json.decode(res.body.toString());
    print(body);
    setState(() {
      // Get the JSON data
      data = body['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Invoice"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[_info()],
        ),
      ),
    );
  }

  Widget _info() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
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
                    data['nomor_invoice'].toString(),
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
                    data['total_transkasi'].toString(),
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
                    data['status'].toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
