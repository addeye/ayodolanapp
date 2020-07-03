import 'package:ayodolan/contants.dart';
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
      // '/wisata/objekwisata.dart': (context) => Objekwisata(),
      //'/second': (context) => SecondHome(),
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curridx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Ayo Dolan Apps"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 46,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              iconBtnAppbar(Icon(Icons.home), "Home", 0),
              iconBtnAppbar(Icon(Icons.swap_horiz), "Orders", 1),
              iconBtnAppbar(Icon(Icons.notifications), "Help", 2),
              iconBtnAppbar(Icon(Icons.question_answer), "Help", 3),
              iconBtnAppbar(Icon(Icons.person), "Profile", 4),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LogIn()));
                              },
                              child: Icon(Icons.beach_access),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Wisata', textAlign: TextAlign.center),
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LogIn()));
                              },
                              child: Icon(Icons.event_available),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Agenda', textAlign: TextAlign.center),
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LogIn()));
                              },
                              child: Icon(Icons.airplanemode_active),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Paket', textAlign: TextAlign.center),
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
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => LogIn()));
                              },
                              child: Icon(Icons.hotel),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Hotel', textAlign: TextAlign.center),
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

  GestureDetector iconBtnAppbar(Widget iconpath, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          curridx = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          iconpath,
          SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 9,
                fontWeight:
                    curridx == index ? FontWeight.w700 : FontWeight.w600,
                color: curridx == index ? PrimaryColor : BottomIcon),
          )
        ],
      ),
    );
  }
}
