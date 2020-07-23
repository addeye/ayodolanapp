import 'package:ayodolan/Agenda/agendapage.dart';
import 'package:ayodolan/Booking/paket.dart';
import 'package:flutter/material.dart';
import 'package:ayodolan/Wisata/wisataPage.dart';
class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildMenu(
            setIcon: Icon(Icons.airplanemode_active),
            text: "Paket Wisata",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Paket()));
            },
          ),
          buildMenu(
            setIcon: Icon(Icons.calendar_today),
            text: "Agenda Kota",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgendaPage()));
            },
          ),
          buildMenu(
            setIcon: Icon(Icons.beach_access),
            text: " Objek Wisata",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WisataPage()));
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class buildMenu extends StatelessWidget {
  final Widget setIcon;
  final String text;
  final Function press;

  const buildMenu({
    Key key,
    this.setIcon,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(.2),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: press,
                child: setIcon,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
