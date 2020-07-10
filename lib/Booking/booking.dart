import 'package:ayodolan/Booking/finish.dart';
import 'package:ayodolan/Contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  dynamic paket;

  Booking({Key key, @required this.paket}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  dynamic data;

  TextEditingController tgl_liburan = TextEditingController();
  TextEditingController jumlah_peserta = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        tgl_liburan.text = _formatdate(picked);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.data = widget.paket;
    super.initState();
    tgl_liburan.text = _formatdate(selectedDate.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Booking Paket"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[_infoPaket(), _form(), _btnContinue()],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _infoPaket() {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.beach_access),
              title: Text(data['nama_paket']),
              subtitle: Text('Liburan ${data['lama_liburan']} hari'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onTap: () {
                _selectDate(context);
              },
              style: TextStyle(color: Color(0xFF000000)),
              controller: tgl_liburan,
              cursorColor: Color(0xFF9b9b9b),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Colors.grey,
                ),
                hintText: "Tanggal Liburan",
                hintStyle: TextStyle(
                    color: Color(0xFF9b9b9b),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
            TextField(
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              style: TextStyle(color: Color(0xFF000000)),
              controller: jumlah_peserta,
              cursorColor: Color(0xFF9b9b9b),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                hintText: "Jumlah Peserta",
                hintStyle: TextStyle(
                    color: Color(0xFF9b9b9b),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnContinue() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: FlatButton(
          color: PrimaryColor,
          child: const Text('Lanjutkan', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FinishBooking(
                        paket: data,
                        tanggal_liburan: tgl_liburan.text,
                        jumlah_peserta: jumlah_peserta.text)));
          },
        ));
  }

  String _formatdate(tdate) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(tdate);
    return formattedDate;
  }
}
