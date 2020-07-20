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
                    subtitle: Text(
                      item['tipe_wisata']
                    ),
          ),

          Container(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(item['deskripsi']),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
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
                  subtitle: Text(
                      item['tipe_wisata']
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
