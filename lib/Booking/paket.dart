import 'dart:convert';

import 'package:ayodolan/Booking/booking.dart';
import 'package:ayodolan/Booking/detail_paket.dart';
import 'package:ayodolan/Account/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Paket extends StatefulWidget {
  Paket({Key key}) : super(key: key);

  @override
  _PaketState createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  List data;

  //Function to get the json
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
  void initState() {
    super.initState();
    this.getJSONData();
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return _buildImageColumn(data[index]);
          // return _buildRow(data[index]);
        });
  }

  Widget _buildImageColumn(dynamic item) => Container(
        decoration: BoxDecoration(color: Colors.white54),
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            new CachedNetworkImage(
              imageUrl: item['gambar_paket'],
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fadeOutDuration: new Duration(seconds: 1),
              fadeInDuration: new Duration(seconds: 3),
            ),
            _buildRow(item)
          ],
        ),
      );

  Widget _buildRow(dynamic item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            item['nama_paket'] == null ? '' : item['nama_paket'],
          ),
          subtitle: Text(item['deskripsi_paket']),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              color: PrimaryColor,
              child:
                  const Text('Booking', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Booking(paket: item)));
              },
            ),
            FlatButton(
              color: PrimaryColor,
              child:
                  const Text('Detail', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaketDetail(
                              paket: item,
                            )));
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 1.0,
          title: Text("Paket Wisata"),
        ),
        body: _buildListView());
  }
}
