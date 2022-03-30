import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:korba_practical/helpers.dart';
import 'package:korba_practical/models/auth_user_model.dart';
import 'package:korba_practical/providers/auth_user_provider.dart';
import 'package:korba_practical/services/app_config.dart';
import 'package:korba_practical/services/shared_preference_store.dart';
import 'package:korba_practical/services/users_api_requests.dart';
import 'package:provider/provider.dart';

class AuthApiRequest {
  final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();
  final _usersApiRequest = GetIt.I.get<UsersApiRequest>();

  Future<dynamic> signIn(BuildContext context, var input) async {
    try {
      final url = Uri.parse(authBaseUrl + 'login');

      var response = await http
          .post(url, headers: headers, body: jsonEncode(input))
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedData['code'] == 0) {
        var responseData = decodedData['data'];
        await _usersApiRequest.getAllUsers(context, responseData['Token'], 1);
        // log(responseData.toString());
        await _sharedPrefStore.saveStringData('token', responseData['Token']);
        await _sharedPrefStore.saveEncodeData('authUserData', responseData);
        context
            .read<AuthUserProvider>()
            .setUserData(AuthUserModel.fromJson(responseData));
        return decodedData['message'];
      } else {
        return decodedData['message'];
      }
      // ignore: unused_catch_clause
    } on TimeoutException catch (t) {
      return 'Could not reach server. Please check your internet connection!';
    } catch (e) {
      log(e.toString());
      return 'Something went wrong. Try again.';
    }
  }

  Future<dynamic> signUp(BuildContext context, var input) async {
    try {
      final url = Uri.parse(authBaseUrl + 'registration');

      var response = await http
          .post(url, headers: headers, body: jsonEncode(input))
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      if (response.statusCode == 200 && decodedData['code'] == 0) {
        var responseData = decodedData['data'];
        log(responseData.toString());
        await _sharedPrefStore.saveStringData('token', responseData['Token']);
        await _sharedPrefStore.saveEncodeData('authUserData', responseData);
        context
            .read<AuthUserProvider>()
            .setUserData(AuthUserModel.fromJson(responseData));
        return decodedData['message'];
      } else {
        return decodedData['message'];
      }
      // ignore: unused_catch_clause
    } on TimeoutException catch (t) {
      return 'Could not reach server. Please check your internet connection!';
    } catch (e) {
      log(e.toString());
      return 'Something went wrong. Try again.';
    }
  }
}
