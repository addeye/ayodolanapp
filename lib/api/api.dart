import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://localhost:3000';

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
    print(fullUrl);
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
