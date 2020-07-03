import 'package:ayodolan/Transaksi/buatTransaksi.dart';
import 'package:ayodolan/Wisata/objekwisata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:ayodolan/Login/loginScreen.dart';

void main() {
  runApp(MaterialApp(
    title: "Ayo Dolan Apps",
    debugShowCheckedModeBanner: true,
    home: HomePage(),
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/wisata/objekwisata.dart': (context) => Objekwisata(),
      //'/second': (context) => SecondHome(),
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Ayo Dolan Apps', style: TextStyle(
                    color: Colors.black,
                  ), textAlign: TextAlign.left),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Objekwisata()));
                                  },
                                  child: Icon(Icons.beach_access),
                                  ),
                                ),
                              ),
                            Text('Objek Wisata', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Objekwisata()));
                                  },
                                  child: Icon(Icons.event_available),
                                ),
                              ),
                            ),
                            Text('Agenda Event', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Objekwisata()));
                                  },
                                  child: Icon(Icons.airplanemode_active),
                                ),
                              ),
                            ),
                            Text('Paket Wisata', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => registrasi()));
                                  },
                                  child: Icon(Icons.monetization_on),
                                ),
                              ),
                            ),
                            Text('Order', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                          ],
                        ),
                      ]),
                      ),

                    ],
                  ),
                  );
  }     
}
class MenuIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String labelMenu;

  MenuIcon({
    this.icon,
    this.iconColor,
    this.labelMenu,
    Null Function() onPressed,
});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.1),
                child: Icon(icon, color: iconColor),
              ),
            ),
            SizedBox(height: 10),
            Text(labelMenu)
          ],
        )
    );
  }
}
