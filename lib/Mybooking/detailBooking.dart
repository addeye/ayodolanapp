import 'dart:convert';

import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetailBooking extends StatefulWidget {
  dynamic transaksi;
  DetailBooking({Key key, @required this.transaksi}) : super(key: key);

  @override
  _DetailBookingState createState() => _DetailBookingState();
}

class _DetailBookingState extends State<DetailBooking> {
  dynamic data;
  bool _isLoading = false;
  String _status = 'batal';

  @override
  void initState() {
    super.initState();
    this.data = widget.transaksi;
    this._status = widget.transaksi['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Detail Booking"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[_info(), _help()],
        ),
      ),
    );
  }

  Widget _help() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Catatan',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: PrimaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                  'Silahkan melakukan pembayaran ke No Rek xxxxxxxx lalu lakukan konfirmasi',
                  style: TextStyle(fontSize: 16.0, color: PrimaryColor))
            ],
          )),
    );
  }

  Widget _info() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                  Text('Nama Paket:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['nama_paket'].toString(),
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
                  Text('Peserta:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['jumlah_peserta'].toString() + ' org',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tanggal Liburan:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['tanggal_liburan'].toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Harga Paket:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['harga'].toString(),
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
                  Text('Tour Guide:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['harga_tour_guide'].toString(),
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
                  Text('Supir:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['harga_supir'].toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
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
                    data['total_transaksi'].toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Status:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(
                    data['status'].toString().toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: _status == 'batal' ? 0.0 : 1.0,
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    color: PrimaryColor,
                    child: const Text('Konfirmasi Pembayaran',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _launchURL();
                    },
                  ),
                  FlatButton(
                    color: Colors.grey,
                    child: Text(_isLoading ? 'Prosess...' : 'Batalkan',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _isLoading
                          ? print('proses')
                          : _cancel(data['id'].toString());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getJSONData() async {
    var res = await CallApi().getDataAuth('my-invoice');
    // var body = json.decode(res.body.toString());
    // print(body);
    // setState(() {
    //   // Get the JSON data
    //   data = body['data'];
    // });
    return res.body;
  }

  _cancel(id) async {
    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().getDataAuth('my-invoice-cancel/' + id);
    var body = json.decode(res.body.toString());

    setState(() {
      // Get the JSON data
      data = body['data'];
      _isLoading = false;
      _status = data['status'];
    });
  }

  _launchURL() async {
    const url = 'https://wa.me/6287751982393';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
