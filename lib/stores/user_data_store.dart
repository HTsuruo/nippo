import 'package:flutter/material.dart';
import 'package:nippo/services/auth.dart';

class UserDataStore with ChangeNotifier {
  User _user;
  User get user => _user;

  void setData({@required User user}) {
    _user = user;
    notifyListeners();
  }
}