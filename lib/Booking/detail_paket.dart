import 'package:ayodolan/Booking/booking.dart';
import 'package:ayodolan/Account/Contants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PaketDetail extends StatelessWidget {
  final paket;
  PaketDetail({this.paket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Detail Paket"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white54),
          margin: const EdgeInsets.all(4),
          child: Column(
            children: [
              new CachedNetworkImage(
                imageUrl: paket['gambar_paket'],
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fadeOutDuration: new Duration(seconds: 1),
                fadeInDuration: new Duration(seconds: 3),
              ),
              _info(),
              _description(),
              _mobil(),
              _hotel(),
              _wisata()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Booking(paket: paket)));
        },
        child: Icon(Icons.calendar_today),
        backgroundColor: PrimaryColor,
      ),
    );
  }

  Widget _info() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            // leading: Icon(Icons.info),
            title: Text(paket['nama_paket']),
            subtitle: Text('Liburan ${paket['lama_liburan']} hari'),
          ),
          ListTile(
              // leading: Icon(Icons.info),
              title: Text(
            paket['harga_final'],
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: PrimaryColor),
          )),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 0.0),
            child: Row(
              children: <Widget>[
                Text('Harga Paket', style: TextStyle(color: Colors.grey)),
                SizedBox(
                  width: 20.0,
                ),
                Text(paket['harga_paket'], style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 0.0),
            child: Row(
              children: <Widget>[
                Text('Harga Supir', style: TextStyle(color: Colors.grey)),
                SizedBox(
                  width: 20.0,
                ),
                Text(paket['harga_supir'], style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Harga Tour Guide',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(paket['harga_tour_guide'],
                    style: TextStyle(color: Colors.grey))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 18.0, color: PrimaryColor),
                  ),
                ),
              ],
            ),
            Text(paket['deskripsi_paket'].toString())
          ],
        ),
      ),
    );
  }

  Widget _mobil() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Info Mobil',
                    style: TextStyle(fontSize: 18.0, color: PrimaryColor),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  paket['mobil']['nama'].toString(),
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Kapasitas ' +
                    paket['mobil']['kapasitas'].toString() +
                    ' Orang'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _hotel() {
    print(paket);
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Info Hotel',
                    style: TextStyle(fontSize: 18.0, color: PrimaryColor),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  paket['hotel']['nama'].toString(),
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(paket['hotel']['alamat'].toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _wisata() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Info Destinasi',
                    style: TextStyle(fontSize: 18.0, color: PrimaryColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                for (var i in paket['detail_paket_wisata'])
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _showImage(i['gambar']),
                        Column(
                          children: <Widget>[
                            Text(
                              i['wisata'],
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text(i['mulai'] + ' - ' + i['selesai'])
                              ],
                            ),
                          ],
                        )
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
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: 80.0,
      height: 80.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: new NetworkImage(photo),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
