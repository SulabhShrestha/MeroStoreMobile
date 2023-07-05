import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// Handles operation related to local storage
class LocalStorageServices {
  static const _uniqueKey = 'userInfo';

  /// Saves user info to local storage
  Future<void> saveUserInfo(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMap = jsonEncode(userData);
    await prefs.setString(_uniqueKey, encodedMap);
    log("User info saved: $encodedMap");
  }

  /// Gets user info from local storage
  Future<Map<String, dynamic>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMap = prefs.getString(_uniqueKey);
    return encodedMap != null ? jsonDecode(encodedMap) : {};
  }

  /// Removes the data saved from local storage
  Future<void> removeUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uniqueKey);
  }
}
