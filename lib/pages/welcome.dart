import 'package:flutter/material.dart';
import 'package:med/pages/intro.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController nome = TextEditingController();

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
                    'Olá, ' + nome.text,
                    style: TextStyle(fontSize: 46),
                  ),
                  SizedBox(height: 32),
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
    setState(() {
      String name = nome.text;
      print(name);
    });
  }

  void submit(String name) {
    setState(() {
      String name = nome.text;
      print(name);
    });
  }
}
