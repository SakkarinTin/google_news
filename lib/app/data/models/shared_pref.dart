import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  // User Display Name
  String get userDisplayName {
    final value = _sharedPrefs?.getString('user_display_name') ?? "Guest";
    debugPrint("Getting userDisplayName: $value");
    return value;
  }

  set userDisplayName(String value) {
    _sharedPrefs?.setString('user_display_name', value);
    debugPrint("Setting userDisplayName: $value");
  }

  // All news data lists contain every category
  // List[0] for Latest category
  // List[1] for Entertainment category
  // and so on..
  // List<List<Map<String, dynamic>>> get newsDataList {
  //   String jsonString = _sharedPrefs?.getString('device_data') ?? '{}';
  //   return jsonDecode(jsonString);
  // }

  set newsDataList(Map<String, dynamic> value) {
    final jsonString = jsonEncode(value);
    _sharedPrefs?.setString('news_data', jsonString);
  }
}

final sharedPrefs = SharedPrefs();
