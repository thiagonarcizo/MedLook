import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
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

  loadSharedPrefs() async {
    try {
      Med med = Med.fromJson(await sharedPref.read("med"));
      setState(() {
        medLoad = med;
        print('ID do medicamento: ${medLoad.id}');
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AutoSizeText(
                  'Qual é o medicamento?',
                  style: const TextStyle(fontSize: 36),
                  maxLines: 1,
                ),
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
                  labelText: 'Nome do medicamento',
                ),
                controller: nomeMed,
                onSubmitted: submitedMed,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: confirmar,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.25,
                      MediaQuery.of(context).size.height * 0.07),
                ),
                child: const Text('Próximo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitedMed(String name) {
    if (nomeMed.text.isNotEmpty) {
      Med med = Med(id: medLoad.id, nome: nomeMed.text.toTitleCase());
      sharedPref.save("med", med.toJson());
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

  void confirmar() {
    if (nomeMed.text.isNotEmpty) {
      Med med = Med(id: medLoad.id, nome: nomeMed.text.toTitleCase());
      sharedPref.save("med", med.toJson());
      loadSharedPrefs();
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
