import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korba_practical/models/auth_user_model.dart';

class AuthUserProvider extends ChangeNotifier {
  AuthUserProvider(var authUserData) {
    if (authUserData != null) {
      _authUserModel = authUserData;
    }
  }

  AuthUserModel _authUserModel = AuthUserModel();

  AuthUserModel get authUserModel => _authUserModel;

  void setUserData(data) {
    _authUserModel = data;
    notifyListeners();
  }
}
