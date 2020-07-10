import 'package:ayodolan/Front/component/bannerslide.dart';
import 'package:ayodolan/Front/component/menu.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  FrontPage({Key key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: <Widget>[Bannerslide(), Menu()],
        ),
      ),
    );
  }
}
