import 'package:med/models/meds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/med.dart';

class SharedPrefMed {
  Future<List<Med>> read() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('meds') ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Med.fromJson(e)).toList();
  }

  void save(List<Med> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('meds', json.encode(value));
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('meds');
  }
}
