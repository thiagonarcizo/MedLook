import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';

const key = 'info';

class Data {
  late SharedPreferences sharedPreferences;

  Future<List<Person>> getPersonData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(key) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Person.fromJson(e)).toList();
  }

  void savePersonData(List<Person> infos) {
    final String jsonString = json.encode(infos);
    sharedPreferences.setString(key, jsonString);
  }
}
