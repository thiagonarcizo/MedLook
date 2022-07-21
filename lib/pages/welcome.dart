import 'package:flutter/material.dart';
import '../models/person.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

_write(String text, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$fileName.txt');
  await file.writeAsString(text);
}

List<Person> infos = [];
final Person person = Person();

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
    person.nome = nome.text;
    setState(() {
      String name = nome.text;
      print(name);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Info()));
      });
    });
  }

  void submit(String name) {
    _write(nome.text, 'nome');
    person.nome = nome.text;
    setState(() {
      String name = nome.text;
      print(name);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
                'Muito bem, ${person.nome}, precisamos de mais informações suas...',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  labelText: 'Quantos anos você tem, ${person.nome}?',
                ),
                controller: idade,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  labelText: 'Qual a sua altura, ${person.nome}?',
                  hintText: 'Exemplo: 180 - Responder em centímetros',
                ),
                controller: altura,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  labelText: '${person.nome}, qual o seu peso?',
                ),
                controller: peso,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (idade.text != '' &&
                    idade.text.length <= 2 &&
                    altura.text != '' &&
                    altura.text.length == 3 &&
                    peso.text != '' &&
                    peso.text.length <= 3) {
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
                  print(infos);
                } else {
                  print('Preencha os campos corretamente!');
                }
              },
              child: const Text('Prosseguir'),
            ),
          ],
        ),
      ),
    );
  }
}
