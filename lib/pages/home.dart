import 'package:flutter/material.dart';
import '../repositories/data.dart';

import '../models/person.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  SharedPref sharedPref = SharedPref();

  Person personSave = Person();

  Person personLoad = Person();

  loadSharedPrefs() async {
    try {
      Person person = Person.fromJson(await sharedPref.read("user"));
      setState(() {
        personLoad = person;
      });
    } catch (Excepetion) {
      print("Nothing found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Olá, ${personLoad.nome}',
                style: const TextStyle(fontSize: 46, color: Colors.white)),
            Text('Sua idade: ${personLoad.idade} anos',
                style: const TextStyle(fontSize: 46, color: Colors.white)),
            Text('Sua altura: ${personLoad.altura} cm',
                style: const TextStyle(fontSize: 46, color: Colors.white)),
            Text('Seu peso: ${personLoad.peso} kg',
                style: const TextStyle(fontSize: 46, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
