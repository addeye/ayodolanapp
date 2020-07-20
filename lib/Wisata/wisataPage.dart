import 'dart:convert';

import 'package:ayodolan/Wisata/wisataDetail.dart';
import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class WisataPage extends StatefulWidget {
  WisataPage({Key key}) : super(key: key);

  @override
  _WisataPageState createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  List data;

  //Function to get the json
  Future<void> getJSONData() async {
    var res = await CallApi().getData('wisata');
    var body = json.decode(res.body.toString());
     print(body);
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
          imageUrl: item['gambar'],
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
            item['nama_wisata'] == null ? '' : item['nama_wisata'],
          ),
          subtitle: Text(item['deskripsi']),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              color: PrimaryColor,
              child:
              const Text('Detail', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WisataDetail(
                          wisata: item,
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
          title: Text("Objek Wisata"),
        ),
        body: _buildListView());
  }
}
