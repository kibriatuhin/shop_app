import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;
  Timer? _authTimer;

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
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expireDate?.toIso8601String()
      });
      prefs.setString('userData', userData);

      //print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async{
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')){
      return false;
    }
    final  extractedUserData = json.decode(prefs.getString("userData").toString()) as Map<String,dynamic>;
    final expiryData = DateTime.parse(extractedUserData['expiryDate']);

    if(expiryData.isBefore(DateTime.now())){
      return false;
    }
    _token  = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expireDate = expiryData;
    notifyListeners();
    _autoLogout();
    return true;
  }
  String? get userId {
    return _userId;
  }

  Future<void> signUp(String email, String password) async {
    return authentic(email, password, "signUp");
  }

  Future<void> signIn(String email, String password) async {
    return authentic(email, password, "signInWithPassword");
  }

  bool get isAuth {
    // print(token);
    return token != null;
  }

  String? get token {
    // print(_expireDate);
    //print(_token);
    //print(_token);
    // print(_expireDate);
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expireDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _expireDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry!), logout);
  }
}
