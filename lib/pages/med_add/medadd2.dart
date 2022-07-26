import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/med_add/medadd3.dart';
import 'package:med/repositories/data.dart';

class MedAdd2 extends StatefulWidget {
  MedAdd2({Key? key}) : super(key: key);

  @override
  State<MedAdd2> createState() => _AddMedState();
}

class _AddMedState extends State<MedAdd2> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  String dropDownValue = 'mg';

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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "mg", child: Text("mg")),
      DropdownMenuItem(value: "g", child: Text("g")),
      DropdownMenuItem(value: "ng", child: Text("ng")),
      DropdownMenuItem(value: "UI", child: Text("UI")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${medLoad.nome}'),
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
                'Qual é a dosagem?',
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
                  labelText: 'Dosagem',
                ),
                controller: nomeMed,
                keyboardType: TextInputType.number,
                //onSubmitted: submitedMed,
                maxLength: 8,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: DropdownButton<String>(
                  value: dropDownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                  items: dropdownItems),
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
      Med med = Med();
      med.nome = medLoad.nome;
      med.dosagem = int.parse(nomeMed.text);
      med.tipoDosagem = dropDownValue;
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd3()));
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
      med.nome = medLoad.nome;
      med.dosagem = int.parse(nomeMed.text);
      med.tipoDosagem = dropDownValue;
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd3()));
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
