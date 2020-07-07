import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://d086bc592d00.ngrok.io/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    print(data);
    print(fullUrl);
    return await http.post(fullUrl, body: jsonEncode(data), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(fullUrl, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
