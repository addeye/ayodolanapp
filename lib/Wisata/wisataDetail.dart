import 'package:ayodolan/Contants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WisataDetail extends StatelessWidget {
  dynamic wisata;
  WisataDetail({Key key, this.wisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Detail Wisata"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            decoration: BoxDecoration(color: Colors.white54),
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                new CachedNetworkImage(
                  imageUrl: wisata['gambar'],
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fadeOutDuration: new Duration(seconds: 1),
                  fadeInDuration: new Duration(seconds: 3),
                ),
                _info(wisata),
                _photo(wisata)
                // _description(),
                // _mobil(),
                // _hotel(),
                // _wisata()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(item) {
    print(item);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            // leading: Icon(Icons.info),
            title: Text(
              item['nama_wisata'],
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor),
            ),
            subtitle: Text(item['tipe_wisata']),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Ciri Khas Objek Wisata',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: PrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        item['ciri_khas'],
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Deskripsi Objek Wisata',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: PrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Center(
                  child: Text(item['deskripsi']),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _photo(item) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Gambar Detail Objek Wisata',
                    style: TextStyle(fontSize: 18.0, color: PrimaryColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                for (var i in item['gambar_detail'])
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        _showImage(i),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _showImage(photo) {
    return new CachedNetworkImage(
      imageUrl: photo,
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      fadeOutDuration: new Duration(seconds: 1),
      fadeInDuration: new Duration(seconds: 3),
    );
  }
}
