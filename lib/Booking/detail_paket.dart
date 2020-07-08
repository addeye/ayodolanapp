import 'dart:convert';

import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';

class PaketDetail extends StatefulWidget {
  final int event_id;
  PaketDetail({Key key, @required this.event_id}) : super(key: key);

  @override
  _PaketDetailState createState() => _PaketDetailState();
}

class _PaketDetailState extends State<PaketDetail> {
  var data;

  Future<void> getJSONData() async {
    var res = await CallApi().getData('paket');
    var body = json.decode(res.body.toString());
    // print(body);
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
        title: Text("Detail Paket"),
      ),
      body: Container(
        child: Text("Paket"),
      ),
    );
  }
}
