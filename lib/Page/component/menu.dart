import 'package:ayodolan/Agenda/agendapage.dart';
import 'package:ayodolan/Booking/paket.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            setIcon: Icon(Icons.beach_access),
            text: "Paket",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Paket()));
            },
          ),
          buildMenu(
            setIcon: Icon(MdiIcons.beach),
            text: "Agenda",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgendaPage()));
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
