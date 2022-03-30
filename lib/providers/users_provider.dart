import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korba_practical/models/users_model.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider(var usersData) {
    if (usersData != null) {
      _usersModel = usersData;
    }
  }

  UsersModel _usersModel = UsersModel();

  UsersModel get usersModel => _usersModel;

  void setUsersData(data) {
    _usersModel = data;
    notifyListeners();
  }
}
