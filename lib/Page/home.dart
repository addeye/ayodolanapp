import 'package:ayodolan/Account/profile_page.dart';
import 'package:ayodolan/Front/front_page.dart';
import 'package:ayodolan/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    title: "Ayo Dolan Apps",
    debugShowCheckedModeBanner: true,
    home: HomePage(),
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      "/Profile": (BuildContext context) => new ProfilePage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curridx = 0;
  final List<Widget> _children = [FrontPage(), ProfilePage()];
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
              iconBtnAppbar(Icon(Icons.person), "Profile", 1),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _children[curridx],
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
