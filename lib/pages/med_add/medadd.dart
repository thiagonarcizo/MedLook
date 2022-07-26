import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/med_add/medadd2.dart';
import 'package:med/repositories/data.dart';

class AddMed extends StatefulWidget {
  AddMed({Key? key}) : super(key: key);

  @override
  State<AddMed> createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  SharedPref sharedPref = SharedPref();

  Med medSave = Med();

  Med medLoad = Med();

  final TextEditingController nomeMed = TextEditingController();

  final TextEditingController _textFieldController = TextEditingController();

  loadSharedPrefs() async {
    try {
      Med med = Med.fromJson(await sharedPref.read("med"));
      setState(() {
        medLoad = med;
      });
    } catch (Excepetion) {
      print("No med found!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar medicação'),
        flexibleSpace:
            Platform.isWindows || Platform.isLinux || Platform.isMacOS
                ? Container(
                    child: MoveWindow(),
                    width: 25,
                  )
                : null,
      ),
      body: Center(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Center(
              child: Text(
                'Qual é o remédio?',
                style: const TextStyle(fontSize: 36),
              ),
            ),
            SizedBox(height: 32),
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
                  labelText: 'Nome do remédio',
                ),
                controller: nomeMed,
                onSubmitted: submitedMed,
                maxLength: 25,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: confirmar,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: const Size(100, 50),
              ),
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }

  void submitedMed(String name) {
    if (nomeMed.text.isNotEmpty) {
      Med med = Med();
      med.nome = nomeMed.text.toTitleCase();
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        sharedPref.save("med", med);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd2()));
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Preencha o campo'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
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

  void confirmar() {
    if (nomeMed.text.isNotEmpty) {
      Med med = Med();
      med.nome = nomeMed.text.toTitleCase();
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd2()));
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Preencha o campo'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
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
}
