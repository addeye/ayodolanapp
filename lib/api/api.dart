import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
<<<<<<< HEAD

  final String _url =  'https://47ab8b30b7d1.ngrok.io/api/';
=======
  final String _url = 'https://cc317dd641c1.ngrok.io/api/';
>>>>>>> abfa92be30f7d9d8c96de4a21a64f238727bca5c

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl, body: jsonEncode(data), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
  }

  postDataAuth(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl, body: jsonEncode(data), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'Authorization': 'Bearer ' + await _getToken(),
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(fullUrl, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
  }

  getDataAuth(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(fullUrl, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ' + await _getToken(),
    });
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
