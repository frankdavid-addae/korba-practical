import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:korba_practical/helpers.dart';
import 'package:korba_practical/models/users_model.dart';
import 'package:korba_practical/providers/users_provider.dart';
import 'package:korba_practical/services/app_config.dart';
import 'package:korba_practical/services/shared_preference_store.dart';
import 'package:provider/provider.dart';

class UsersApiRequest {
  final _sharedPrefStore = GetIt.I.get<SharedPrefStore>();

  Future<dynamic> getAllUsers(
      BuildContext context, String token, int page) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final url = Uri.parse(usersBaseUrl + '?page=:$page');

      var response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      // log(decodedData.toString());

      if (response.statusCode == 200) {
        var responseData = decodedData['data'];
        // log(responseData.toString());
        await _sharedPrefStore.saveEncodeData('usersData', responseData);
        context
            .read<UsersProvider>()
            .setUsersData(UsersModel.fromJson(responseData));
        return responseData;
      } else {
        return decodedData;
      }
      // ignore: unused_catch_clause
    } on TimeoutException catch (t) {
      return 'Could not reach server. Please check your internet connection!';
    } catch (e) {
      log(e.toString());
      return 'Something went wrong. Try again.';
    }
  }

  Future<dynamic> getOneUser(BuildContext context, String token, int id) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final url = Uri.parse(usersBaseUrl + '/$id');

      var response = await http
          .get(url, headers: requestHeaders)
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      // log(decodedData.toString());

      if (response.statusCode == 200) {
        await _sharedPrefStore.saveEncodeData('userData', decodedData);
        return decodedData;
      } else {
        return decodedData;
      }
      // ignore: unused_catch_clause
    } on TimeoutException catch (t) {
      return 'Could not reach server. Please check your internet connection!';
    } catch (e) {
      log(e.toString());
      return 'Something went wrong. Try again.';
    }
  }

  Future<dynamic> deleteUser(BuildContext context, String token, int id) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final url = Uri.parse(usersBaseUrl + '/$id');

      var response = await http
          .delete(url, headers: requestHeaders)
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      // log(decodedData.toString());

      if (response.statusCode == 200) {
        // log('Deleted');
        return 'success';
      } else {
        return decodedData;
      }
      // ignore: unused_catch_clause
    } on TimeoutException catch (t) {
      return 'Could not reach server. Please check your internet connection!';
    } catch (e) {
      log(e.toString());
      return 'Something went wrong. Try again.';
    }
  }

  Future<dynamic> updateUser(BuildContext context, String token, int id) async {
    Map<String, String> requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      final url = Uri.parse(usersBaseUrl + '/$id');

      var response = await http
          .put(url, headers: requestHeaders)
          .timeout(Duration(seconds: Helpers.timeOutSeconds));
      var decodedData = jsonDecode(response.body);

      // log(decodedData.toString());

      if (response.statusCode == 200) {
        // log('Deleted');
        return 'success';
      } else {
        return decodedData;
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
