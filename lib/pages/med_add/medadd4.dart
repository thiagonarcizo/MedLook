import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/home.dart';
import 'package:med/pages/med_add/clock1.dart';
import 'package:med/pages/med_add/clock2.dart';
import 'package:med/pages/med_add/clock3.dart';
import 'package:med/pages/med_add/clock4.dart';
import 'package:med/pages/med_add/clock6.dart';
import 'package:med/pages/med_add/clock8.dart';
import 'package:med/repositories/data.dart';

class MedAdd4 extends StatefulWidget {
  MedAdd4({Key? key}) : super(key: key);

  @override
  State<MedAdd4> createState() => _AddMedState();
}

class _AddMedState extends State<MedAdd4> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  String dropDownValue = '2';

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
      DropdownMenuItem(
          value: "1", child: Text("1x ao dia - de 24 em 24 horas")),
      DropdownMenuItem(
          value: "2", child: Text("2x ao dia - de 12 em 12 horas")),
      DropdownMenuItem(value: "3", child: Text("3x ao dia - de 8 em 8 horas")),
      DropdownMenuItem(value: "4", child: Text("4x ao dia - de 6 em 6 horas")),
      DropdownMenuItem(value: "6", child: Text("6x ao dia - de 4 em 4 horas")),
      DropdownMenuItem(value: "8", child: Text("8x ao dia - de 3 em 3 horas")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          '${medLoad.quantidade} ${medLoad.tipoQuantidade} de ${medLoad.nome}',
          style: TextStyle(
            color: Colors.white,
            fontSize: Platform.isWindows || Platform.isLinux || Platform.isMacOS
                ? 36
                : 56,
          ),
          maxLines: 1,
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
                'Qual é a posologia?',
                style: const TextStyle(fontSize: 36),
              ),
            ),
            SizedBox(height: 32),
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
            const SizedBox(height: 32),
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
      med.quantidade = medLoad.quantidade;
      med.tipoQuantidade = medLoad.tipoQuantidade;
      med.posologia = int.parse(dropDownValue);
      med.id = medLoad.id;
      sharedPref.save("med", med);
      setState(() {
        String name = nomeMed.text.toTitleCase();
        print(name.toTitleCase());
        Future.delayed(const Duration(seconds: 1), () {
          /*Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MedAdd3()));*/
        });
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
    Med med = Med();
    med.nome = medLoad.nome;
    med.dosagem = medLoad.dosagem;
    med.tipoDosagem = medLoad.tipoDosagem;
    med.quantidade = medLoad.quantidade;
    med.tipoQuantidade = medLoad.tipoQuantidade;
    med.posologia = int.parse(dropDownValue);
    med.id = medLoad.id;
    sharedPref.save("med", med);
    setState(() {
      String name = nomeMed.text.toTitleCase();
      print(name.toTitleCase());
      if (dropDownValue == '1')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock1()));
      else if (dropDownValue == '2')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock2()));
      else if (dropDownValue == '3')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock3()));
      else if (dropDownValue == '4')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock4()));
      else if (dropDownValue == '6')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock6()));
      else if (dropDownValue == '8')
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Clock8()));
    });
  }
}
