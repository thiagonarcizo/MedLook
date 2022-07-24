import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import '../models/person.dart';
import '../repositories/data.dart';
import 'home.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  SharedPref sharedPref = SharedPref();

  Person personSave = Person();

  Person personLoad = Person();

  final TextEditingController _textFieldController = TextEditingController();

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
      appBar: upMenu(),
      drawer: SideMenu(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  'Oi, ${personLoad.nome}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 56,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _displayTextInputDialog(
                                            'Digite seu nome:', context,
                                            max: 25, type: null);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Idade: ${personLoad.idade} anos',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        setState(() {
                          _displayTextInputDialog('Sua idade:', context);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Altura: ${personLoad.altura} cm',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        setState(() {
                          _displayTextInputDialog('Sua altura:', context);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      title: Text(
                        'Peso: ${personLoad.peso} kg',
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        setState(() {
                          _displayTextInputDialog('Seu peso:', context);
                        });
                      },
                    ),
                  ),
                  /*Padding(
                  padding: const EdgeInsets.symmetric(vertical: 64.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Você possui ${personLoad.idade} anos',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Mede ${personLoad.altura} cm',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'E pesa ${personLoad.peso} kg',
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          fixedSize: const Size(250, 50),
                        ),
                        child: const Text('Desejo alterar meus dados'),
                      ),
                    ],
                  ),
                ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(String text, BuildContext context,
      {int? max, TextInputType? type = TextInputType.number}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            content: TextField(
              keyboardType: type,
              controller: _textFieldController,
              maxLength: max,
              decoration: const InputDecoration(
                hintText: "Digite aqui",
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCELAR'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    _textFieldController.clear();
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  if (text.contains('idade') &&
                      _textFieldController.text.length <= 2 &&
                      _textFieldController.text != null &&
                      _textFieldController.text.toString() != '') {
                    Person newPerson = Person(
                      nome: personLoad.nome,
                      idade: int.parse(_textFieldController.text),
                      altura: personLoad.altura,
                      peso: personLoad.peso,
                    );
                    setState(() {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    });
                    sharedPref.save("user", newPerson);
                    loadSharedPrefs();
                  } else if (text.contains('altura') &&
                      _textFieldController.text.length <= 3 &&
                      _textFieldController.text != null &&
                      _textFieldController.text.toString() != '') {
                    Person newPerson = Person(
                      nome: personLoad.nome,
                      idade: personLoad.idade,
                      altura: int.parse(_textFieldController.text),
                      peso: personLoad.peso,
                    );
                    setState(() {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    });
                    sharedPref.save("user", newPerson);
                    loadSharedPrefs();
                  } else if (text.contains('peso') &&
                      _textFieldController.text.length <= 6 &&
                      _textFieldController.text != null &&
                      _textFieldController.text.toString() != '') {
                    Person newPerson = Person(
                      nome: personLoad.nome,
                      idade: personLoad.idade,
                      altura: personLoad.altura,
                      peso: double.parse(_textFieldController.text),
                    );
                    setState(() {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    });
                    sharedPref.save("user", newPerson);
                    loadSharedPrefs();
                  } else if (text.contains('nome') &&
                      _textFieldController.text != null &&
                      _textFieldController.text.toString() != '') {
                    Person newPerson = Person(
                      nome: _textFieldController.text.toTitleCase(),
                      idade: personLoad.idade,
                      altura: personLoad.altura,
                      peso: personLoad.peso,
                    );
                    setState(() {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    });
                    sharedPref.save("user", newPerson);
                    loadSharedPrefs();
                  } else {
                    _showDialog(context);
                  }
                },
              ),
            ],
          );
        });
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

PreferredSizeWidget upMenu() {
  return AppBar(
    title: const Text('Perfil'),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: const [
            SizedBox(width: 12),
          ],
        ),
      ),
    ],
    backgroundColor: Colors.black,
  );
}
