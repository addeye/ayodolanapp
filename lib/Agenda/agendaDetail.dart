import 'package:ayodolan/Contants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgendaDetail extends StatelessWidget {
  dynamic event;
  AgendaDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Detail Agenda"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            decoration: BoxDecoration(color: Colors.white54),
            margin: const EdgeInsets.all(4),
            child: Column(
              children: [
                _info(event),
                _photo(event)
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
            item['tanggal'],
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: PrimaryColor),
          )),
          ListTile(
            // leading: Icon(Icons.info),
            title: Text(item['nama_event']),
            subtitle: Text(item['lokasi']),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text(item['deskripsi_event']),
            ),
          )
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
                    'Gambar Detail Agenda',
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
