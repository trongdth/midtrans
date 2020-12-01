import 'package:flutter/material.dart';
import 'package:flutter_midtrans/helpers/theme/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const THEME_MODE = 'THEME_MODE';

class Storage {
  static final Storage _singleton = new Storage._internal();
  SharedPreferences _prefs;

  factory Storage() {
    return _singleton;
  }

  Storage._internal();

  Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  registerTestPreference(SharedPreferences sharedPreferences) {
    _prefs = sharedPreferences;
  }

  ThemeMode getThemeMode() {
    ThemeEnum themeEnum = ThemeEnum.getThemeByThemeMode(_prefs.getString(THEME_MODE));
    return themeEnum.themeMode;
  }

  setThemeMode(ThemeMode themeMode) {
    _prefs.setString(THEME_MODE, themeMode.toString());
  }

  Future<void> saveBoolean(String key, bool value) async {
    _prefs.setBool(key, value);
  }

  Future<bool> getBoolean(String key) async {
    return _prefs.getBool(key) ?? false;
  }

  Future<void> saveString(String key, String value) async {
    _prefs.setString(key, value);
  }

  Future<void> remove(String key) async {
    _prefs.remove(key);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  Future<void> saveInt(String key, int value) async {
    _prefs.setInt(key, value);
  }

  int getInt(String key) {
    return _prefs.getInt(key) ?? -1;
  }

  Future<void> saveDouble(String key, double value) async {
    _prefs.setDouble(key, value);
  }

  Future<double> getDouble(String key) async {
    return _prefs.getDouble(key) ?? 0;
  }
}

final storage = Storage();
