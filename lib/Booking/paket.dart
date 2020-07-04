import 'package:ayodolan/Contants.dart';
import 'package:flutter/material.dart';

class Paket extends StatefulWidget {
  Paket({Key key}) : super(key: key);

  @override
  _PaketState createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Paket"),
      ),
    );
  }
}
