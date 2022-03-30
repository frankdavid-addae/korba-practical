import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStore {
  Future<void> saveEncodeData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    String encodeData = jsonEncode(value);
    await prefs.setString(key, encodeData);
  }

  Future<void> saveStringData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> saveIntegerData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> saveDoubleData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<void> saveBoolData(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> reloadData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
  }

  Future<void> removeStoredData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<Map<String, dynamic>?> retrieveDecodeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    Map<String, dynamic>? mapData = (data != null) ? jsonDecode(data) : {};
    return mapData;
  }

  Future<dynamic> retrieveDecodeDynamicData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    return data != null ? jsonDecode(data) : null;
  }

  Future<String?> retrieveStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> retrieveIntData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double?> retrieveDoubleData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<bool?> retrieveBoolData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
