import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_manager/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get userProfile => _user;

  void setUser(UserModel user) {
    bool _userInHotel = _user.inHotel ?? false;
    _user = user;
    _user.inHotel = _userInHotel;
    savePreferences(_user);
    notifyListeners();
  }

  void removeUser() async {
    _user = UserModel();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('user');
    notifyListeners();
  }

  void savePreferences(UserModel user) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('user', jsonEncode(user));
  }

  initUser({bool? inHotel}) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if(prefs.getKeys().contains('user')) {
      var userJson = jsonDecode(prefs.getString('user') ?? '');
      _user = UserModel.fromJSON(userJson);
      if(_user.inHotel == null) 
        _user.inHotel = inHotel;
    }
  }

  void setUserInHotel(bool value) async {
    await initUser(inHotel: value);
    savePreferences(_user);
    notifyListeners();
  }
}