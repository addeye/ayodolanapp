import 'dart:convert';
import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/Mybooking/detailBooking.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';

class MyBooking extends StatefulWidget {
  MyBooking({Key key}) : super(key: key);

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  // List data;

  //Function to get the json
  Future<void> getJSONData() async {
    var res = await CallApi().getDataAuth('my-invoice');
    // var body = json.decode(res.body.toString());
    // print(res);
    // setState(() {
    //   // Get the JSON data
    //   data = body['data'];
    // });
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJSONData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _buildListView(
                json.decode(snapshot.data.toString())['data']);
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

  Widget _buildListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildRow(data[index]);
          // return _buildRow(data[index]);
        });
  }

  Widget _buildRow(dynamic item) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item['nomor_invoice'],
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Text(
                  item['status'].toString().toUpperCase(),
                  style: TextStyle(
                      color: PrimaryColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(item['tanggal_invoice'],
                    style: TextStyle(color: Colors.grey))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Text(item['total_transaksi'],
                    style: TextStyle(color: Colors.grey))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    color: PrimaryColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailBooking(transaksi: item)));
                    },
                    child:
                        Text('Detail', style: TextStyle(color: Colors.white)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
