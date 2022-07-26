//Carro-chefe do aplicativo: ideia da rodela de horário

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/home.dart';
import 'package:med/repositories/data.dart';
import 'package:med/repositories/meddata.dart';

import '../../models/meds.dart';
import '../../models/todbuilder.dart';

class Clock2 extends StatefulWidget {
  Clock2({Key? key}) : super(key: key);

  @override
  State<Clock2> createState() => _AddMedState();
}

class _AddMedState extends State<Clock2> {
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

  TimeOfDay selectedTime2 = TimeOfDay.now();

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
            color: Colors.white,
            fontSize: 56,
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 45),
                    ),
                    child: Text("${selectedTime.format(context)}"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _selectTime2(context);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 45),
                    ),
                    child: Text("${selectedTime2.format(context)}"),
                  ),
                ],
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
                child: const Text('Finalizar'),
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
        selectedTime2 =
            TimeOfDayBuilder(time: selectedTime, amount: 2).timeFix();
      });
    }
  }

  _selectTime2(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timeOfDay != null && timeOfDay != selectedTime2) {
      setState(() {
        selectedTime2 = timeOfDay;
        selectedTime =
            TimeOfDayBuilder(time: selectedTime2, amount: 2).timeFix();
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
          hora1: selectedTime.format(context),
          hora2: selectedTime2.format(context));
      medsLoad.add(med);
      sharedPrefMed.save(medsLoad);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    });
  }
}
