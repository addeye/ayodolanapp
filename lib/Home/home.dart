import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    title: "Ayo Dolan Apps",
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HomeController {
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
              delegate: SliverChildBuilderDelegate([
                GridView.builder(
                shrinkWrap: true,
                  itemBuilder: (BuildContext _, int index) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                               decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                                 child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(Icons.hotel),
                              )
                              ),
                              Text('Hotel')
                           ],
                          )
                       );
                    },
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20
              ),
          ],
        )
    );
  }
}
