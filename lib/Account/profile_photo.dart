import 'dart:convert';
import 'dart:io';

import 'package:ayodolan/Account/profile_page.dart';
import 'package:ayodolan/Account/Contants.dart';
import 'package:ayodolan/Page/home.dart';
import 'package:ayodolan/api/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profilPhoto extends StatefulWidget {
  profilPhoto({Key key}) : super(key: key);

  @override
  _profilPhotoState createState() => _profilPhotoState();
}

class _profilPhotoState extends State<profilPhoto> {
  File _image;
  final picker = ImagePicker();
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    final bytes = await pickedFile.readAsBytes();

    setState(() {
      _image = File(pickedFile.path);
      base64Image = base64Encode(bytes);
      status = 'upload gambar';
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Upload foto...');
    upload();
  }

  Future<void> upload() async {
    var data = {
      "image": base64Image,
    };

    try {
      var result = await CallApi().postDataAuth(data, 'user-photo');
      var body = json.decode(result.body.toString());
      print(body);
      if (body['status']) {
        Navigator.pop(context, true);
        // _showMsg(body['message'].toString());
        // Navigator.pop(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // _showMsg(body['message'].toString());
      }
    } catch (e) {
      setStatus(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 1.0,
        title: Text('Upload Foto'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),
              Opacity(
                opacity: _image == null ? 0.0 : 1.0,
                child: FlatButton(
                    color: PrimaryColor,
                    textColor: Colors.white,
                    onPressed: startUpload,
                    child: Text(status)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PrimaryColor,
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
