import 'package:ayodolan/Account/Contants.dart';
import 'package:flutter/material.dart';

class WisataCari extends StatefulWidget {
  String searchKey;
  WisataCari({Key key, @required this.searchKey}) : super(key: key);

  @override
  _WisataCariState createState() => _WisataCariState();
}

class _WisataCariState extends State<WisataCari> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    search.text = widget.searchKey;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text("Pencarian Objek Wisata"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(color: Color(0xFF000000)),
              controller: search,
              cursorColor: Color(0xFF9b9b9b),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: "Nama / Jenis Objek Wisata...",
                hintStyle: TextStyle(
                    color: Color(0xFF9b9b9b),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  color: Colors.grey,
                  child: const Text('Reset',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      search.text = '';
                    });
                    Navigator.pop(context, search.text);
                  },
                ),
                FlatButton(
                  color: PrimaryColor,
                  child: const Text('Terapkan',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context, search.text);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
