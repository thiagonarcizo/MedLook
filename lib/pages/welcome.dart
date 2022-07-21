import 'package:flutter/material.dart';
import 'package:med/pages/intro.dart';
import '/pages/info.dart' as info;
import '../models/person.dart';
import 'info.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

_write(String text, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$fileName.txt');
  await file.writeAsString(text);
}

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController nome = TextEditingController();
  List<Person> infos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Column(
                children: [
                  Text(
                    'Olá, ${nome.text}',
                    style: const TextStyle(fontSize: 46),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        labelText: 'Qual o seu nome?',
                      ),
                      controller: nome,
                      onSubmitted: submit,
                      maxLength: 25,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: confirmar,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(100, 50),
                      primary: Colors.black,
                    ),
                    child: Text('Confirma'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmar() {
    _write(nome.text, 'Nome');
    setState(() {
      String name = nome.text;
      print(name);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Info()));
      });
    });
  }

  void submit(String name) {
    _write(nome.text, 'nome');
    setState(() {
      String name = nome.text;
      print(name);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Info()));
      });
    });
  }
}
