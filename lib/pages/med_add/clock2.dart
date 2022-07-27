//Carro-chefe do aplicativo: ideia da rodela de horário

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/pages/med_add/medcalendar.dart';
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

  late TimeOfDay selectedTime2 = TimeOfDay.now();

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
                child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: AutoSizeText(
                  "Selecione pelo menos uma hora no dia em que deseja tomar o medicamento:",
                  style: TextStyle(fontSize: 48),
                  maxLines: 1,
                ),
              ),
            )),
            Center(
              child: SizedBox(
                height: 32,
              ),
            ),
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
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: AutoSizeText(
                  'Os horários para tormar o medicamento são:\n${TimeOfDayBuilder(horarios: [
                        selectedTime,
                        selectedTime2
                      ]).timeSort(context).join('; ')}',
                  style: TextStyle(fontSize: 36),
                  maxFontSize: 36,
                  maxLines: 3,
                ),
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
        selectedTime2 =
            TimeOfDayBuilder(time: selectedTime, amount: 2).timeFix();
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
      sharedPref.save("med", med);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MedCalendar()));
    });
  }
}
