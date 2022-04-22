import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Auth extends ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;

  Future<void> authentic(String email, String password, String urlName) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlName?key=AIzaSyCmx_xdN29IoNwaOmrmMjCvFBGJQ0Pj0Ds";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _userId = responseData['localId'];

      notifyListeners();
      //print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }
  String? get userId{
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    return authentic(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return authentic(email, password, "signInWithPassword");
  }

  bool get isAuth {
    print(token);
    return token != null;
  }

  String? get token {
   // print(_expireDate);
    //print(_token);
    //print(_token);
    print(_expireDate);
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }
}
