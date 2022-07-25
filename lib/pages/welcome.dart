import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../repositories/data.dart';

_write(String text, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$fileName.txt');
  await file.writeAsString(text);
}

List<Person> infos = [];
Person person = Person();

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
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Olá, ${nome.text.toTitleCase()}',
                  style: const TextStyle(fontSize: 46),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
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
                const SizedBox(height: 16),
                TextButton(
                  onPressed: confirmar,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(100, 50),
                    primary: Colors.black,
                  ),
                  child: const Text('Confirma'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmar() {
    _write(nome.text.toTitleCase(), 'Nome');
    person.nome = nome.text.toTitleCase();
    setState(() {
      String name = nome.text.toTitleCase();
      print(name.toTitleCase());
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Info()));
      });
    });
  }

  void submit(String name) {
    _write(nome.text.toTitleCase(), 'nome');
    person.nome = nome.text.toTitleCase();
    setState(() {
      String name = nome.text.toTitleCase();
      print(name.toTitleCase());
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Info()));
      });
    });
  }
}

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  final TextEditingController idade = TextEditingController();
  final TextEditingController altura = TextEditingController();
  final TextEditingController peso = TextEditingController();
  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: ListView(padding: EdgeInsets.zero, children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                      'Muito bem, ${person.nome}, precisamos de mais informações suas...',
                      style: const TextStyle(fontSize: 24)),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      labelText: 'Quantos anos você tem?',
                    ),
                    controller: idade,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      labelText: 'Qual a sua altura?',
                      hintText: 'Exemplo: 180 - Responder em centímetros',
                    ),
                    controller: altura,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      labelText: 'Qual o seu peso?',
                      hintText:
                          'Exemplo: 80.5 - usar ponto para separar casas decimais',
                    ),
                    controller: peso,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      if (idade.text != '' &&
                          idade.text.length <= 2 &&
                          altura.text != '' &&
                          altura.text.length == 3 &&
                          peso.text != '' &&
                          peso.text.length <= 5) {
                        person.idade = int.parse(idade.text);
                        person.altura = int.parse(altura.text);
                        person.peso = double.parse(peso.text);
                        Person user = Person(
                          nome: person.nome,
                          idade: person.idade,
                          altura: person.altura,
                          peso: person.peso,
                        );
                        infos.add(user);
                        idade.clear();
                        altura.clear();
                        peso.clear();
                        sharedPref.save("user", person);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showWelcome', true);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      } else {
                        _showDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      fixedSize: const Size(100, 45),
                    ),
                    child: const Text('Prosseguir')),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Preencha todos os campos corretamente!"),
          content: const Text(
              "Verifique se todos os campos foram preenchidos corretamente."),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Fechar",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
