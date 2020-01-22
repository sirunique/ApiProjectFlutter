import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
    // localhost with EMULATOR
  final String _url = 'http://10.0.2.2:8000/api/';
  
  // HEROKU URL
  // final String _url = 'https://flutterlaravel.herokuapp.com/api/';

  postData(data, apiUrl) async{
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(
        fullUrl, 
        headers: _setHeaders(),
        body: jsonEncode(data),
    );
  }

  getData(apiUrl) async{
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(
      fullUrl,
      headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

}