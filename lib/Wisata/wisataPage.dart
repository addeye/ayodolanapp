import 'dart:convert';

import 'package:ayodolan/Wisata/wisataCari.dart';
import 'package:ayodolan/Wisata/wisataDetail.dart';
import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WisataPage extends StatefulWidget {
  WisataPage({Key key}) : super(key: key);

  @override
  _WisataPageState createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  List data;
  String _search = '';
  bool isLoading = false;

  //Function to get the json
  Future<void> getJSONData() async {
    setState(() {
      isLoading = true;
    });
    var res = await CallApi().getData('wisata?search=' + _search);
    var body = json.decode(res.body.toString());
    print(body);
    setState(() {
      // Get the JSON data
      data = body['data'];
      isLoading = false;
    });
  }

  void updateInformation(String search) {
    setState(() => _search = search);
  }

  void moveToWisataCari() async {
    final search = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => WisataCari(searchKey: _search)),
    );
    updateInformation(search);
    getJSONData();
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }

  Widget _buildListView() {
    return data.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              return _buildImageColumn(data[index]);
              // return _buildRow(data[index]);
            })
        : Center(
            child: Column(
            children: <Widget>[
              Text(
                'Tidak ada data!',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              SvgPicture.asset(
                'assets/empty.svg',
                width: 250.0,
              )
            ],
          ));
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

  Widget baseBuild() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  color: PrimaryColor,
                  onPressed: moveToWisataCari,
                  child: Text(
                    'Pencarian',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ))
            ],
          ),
        ),
        Expanded(child: _buildListView())
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: baseBuild(),
              ));
  }
}
