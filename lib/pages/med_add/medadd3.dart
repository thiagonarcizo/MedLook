import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/med_add/medadd4.dart';
import 'package:med/repositories/data.dart';

class MedAdd3 extends StatefulWidget {
  MedAdd3({Key? key}) : super(key: key);

  @override
  State<MedAdd3> createState() => _AddMedState();
}

class _AddMedState extends State<MedAdd3> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  String dropDownValue = 'comprimido(s)';

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
        print('ID do medicamento: ${medLoad.id}');
      });
    } catch (Excepetion) {
      print("No med found!");
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "comprimido(s)", child: Text("Comprimido(s)")),
      DropdownMenuItem(value: "cápsula(s)", child: Text("Cápsula(s)")),
      DropdownMenuItem(value: "gotas", child: Text("Gotas")),
      DropdownMenuItem(value: "spray(s)", child: Text("Spray(s)")),
      DropdownMenuItem(value: "mL", child: Text("mL")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          (() {
            if (medLoad.dosagem != null) {
              return "${medLoad.dosagem} ${medLoad.tipoDosagem} de ${medLoad.nome}";
            }

            return "Dosagem não informada";
          })(),
          maxFontSize: 56,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
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
                'Qual é a quantidade de uma vez?',
                style: const TextStyle(fontSize: 24),
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
                  labelText: 'Quantidade',
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
      med.dosagem = medLoad.dosagem;
      med.tipoDosagem = medLoad.tipoDosagem;
      med.quantidade = int.parse(nomeMed.text);
      med.tipoQuantidade = dropDownValue;
      med.id = medLoad.id;
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd4()));
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
      med.dosagem = medLoad.dosagem;
      med.tipoDosagem = medLoad.tipoDosagem;
      med.quantidade = int.parse(nomeMed.text);
      med.tipoQuantidade = dropDownValue;
      med.id = medLoad.id;
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MedAdd4()));
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
