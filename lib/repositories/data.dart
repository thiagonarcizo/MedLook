import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  Future read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString(key)!;
    final jsonDecoded = json.decode(jsonString);
    return jsonDecoded;
  }

  Future save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
