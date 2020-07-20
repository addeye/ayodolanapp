import 'dart:convert';

import 'package:ayodolan/Booking/invoice.dart';
import 'package:ayodolan/Contants.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FinishBooking extends StatefulWidget {
  dynamic paket;

  String tanggalLiburan;

  String jumlahPeserta;

  FinishBooking(
      {Key key,
      @required this.paket,
      @required this.tanggalLiburan,
      @required this.jumlahPeserta})
      : super(key: key);

  @override
  _FinishBookingState createState() => _FinishBookingState();
}

class _FinishBookingState extends State<FinishBooking> {
  dynamic data;
  int total;
  String count;
  String tgl;

  final formatter =
      NumberFormat.currency(locale: 'ID', customPattern: '\u00a4 #,###');

  @override
  void initState() {
    super.initState();
    this.data = widget.paket;
    this.count = widget.jumlahPeserta;
    this.tgl = widget.tanggalLiburan;
    this.total = this.data['harga_final_r'] * int.parse(this.count);
    print('count ' + this.count);
    print('total ' + this.total.toString());
  }

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Review Booking"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[_paket(), _detail(), _total()],
        ),
      ),
    );
  }

  Widget _paket() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nama Paket',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['nama_paket'],
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Harga Paket:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text('@ ' + count + ' Orang',
                      style: TextStyle(color: Colors.grey)),
                  Text(
                    data['harga_paket'],
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
                  Text('Harga Supir:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['harga_supir'],
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
                  Text('Harga Tour Guide:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    data['harga_tour_guide'],
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _total() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  formatter.format(total),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 24.0, color: PrimaryColor),
                )
              ],
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    color: PrimaryColor,
                    onPressed: () {
                      _paynow();
                    },
                    child: Text(
                      'Bayar Sekarang',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _paynow() async {
    setState(() {});

    var datarow = {
      'paket_id': data['id'].toString(),
      'jumlah_peserta': count,
      'total_transaksi': total,
      'tanggal_liburan': tgl,
      'harga_supir': data['harga_supir'],
      'harga_tour_guide': data['harga_tour_guide'],
      'harga_paket': data['harga_paket'],
    };
    // print(datarow);
    var res = await CallApi().postDataAuth(datarow, 'invoice');
    var body = json.decode(res.body.toString());
    print(body);
    if (body['status']) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  Invoice(transkasiId: body['data']['id'].toString())));
    } else {
      _showMsg(body['message']);
    }

    setState(() {});
  }
}
