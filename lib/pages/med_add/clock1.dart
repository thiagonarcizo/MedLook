//Carro-chefe do aplicativo: ideia da rodela de horário

import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/extensions/timeofdayto24h.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/med_add/medcalendar.dart';
import 'package:med/repositories/data.dart';
import 'package:med/repositories/meddata.dart';

import '../../models/meds.dart';

class Clock1 extends StatefulWidget {
  Clock1({Key? key}) : super(key: key);

  @override
  State<Clock1> createState() => _AddMedState();
}

class _AddMedState extends State<Clock1> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  String dropDownValue = '2';

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    sharedPrefMed.read().then((value) {
      setState(() {
        medsLoad = value;
      });
    });
  }

  SharedPref sharedPref = SharedPref();

  SharedPrefMed sharedPrefMed = SharedPrefMed();

  Meds meds = Meds();

  Med medSave = Med();

  Med medLoad = Med();

  List<Med> medsLoad = [];

  final TextEditingController nomeMed = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

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
        title: AutoSizeText(
          '${medLoad.quantidade} ${medLoad.tipoQuantidade} de ${medLoad.nome}',
          style: const TextStyle(
            fontSize: 32,
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
              child: ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 45),
                ),
                child: Text("${selectedTime.format(context)}"),
              ),
            ),
            SizedBox(height: 32),
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

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  void confirmar() {
    setState(() {
      Med med = Med(
          nome: medLoad.nome!.toTitleCase(),
          dosagem: medLoad.dosagem,
          tipoDosagem: medLoad.tipoDosagem,
          quantidade: medLoad.quantidade,
          tipoQuantidade: medLoad.tipoQuantidade,
          posologia: medLoad.posologia,
          hora1: selectedTime.to24h(context));
      med.id = medLoad.id;
      sharedPref.save("med", med);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MedCalendar()));
    });
  }
}
