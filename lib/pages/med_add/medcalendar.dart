import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:med/extensions/stringext.dart';
import 'package:med/models/med.dart';
import 'package:med/models/notification_api.dart';
import 'package:med/pages/home.dart';
import 'package:med/repositories/data.dart';
import 'package:med/repositories/meddata.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../../models/meds.dart';

class MedCalendar extends StatefulWidget {
  MedCalendar({Key? key}) : super(key: key);

  @override
  State<MedCalendar> createState() => _MedCalendar();
}

class _MedCalendar extends State<MedCalendar> {
//sharedPref.save("med", med);
  //loadSharedPrefs();

  String dropDownValue = '2';

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows == false) {
      NotificationApi.init(initScheduled: true);
      listenNotifications();
    }
    loadSharedPrefs();
    sharedPrefMed.read().then((value) {
      setState(() {
        medsLoad = value;
      });
    });
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) => print('Notificação clicada');

  late List<String?> horariosNull = [
    medLoad.hora1,
    medLoad.hora2,
    medLoad.hora3,
    medLoad.hora4,
    medLoad.hora5,
    medLoad.hora6,
    medLoad.hora7,
    medLoad.hora8,
  ];

  late List<String> horarios = horariosNull.whereType<String>().toList()
    ..sort();

  SharedPref sharedPref = SharedPref();

  SharedPrefMed sharedPrefMed = SharedPrefMed();

  Meds meds = Meds();

  Med medSave = Med();

  Med medLoad = Med();

  List<Med> medsLoad = [];

  bool isChecked = false;

  Med? notificationMed;

  int? notificationMedPos;

  final TextEditingController nomeMed = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        String _range =
            '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        DateTime inicio = args.value.startDate;
        DateTime fim = args.value.endDate ?? args.value.startDate;
        int dias = fim.difference(inicio).inDays + 1;
        medLoad.dataInicio = inicio;
        medLoad.dataFim = fim;
        medLoad.diasTratamento = dias;
      } else if (args.value is DateTime) {
        String _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        String _dateCount = args.value.length.toString();
      } else {
        String _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          '${medLoad.quantidade} ${medLoad.tipoQuantidade} de ${medLoad.nome}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  'Marque os dias de início e de fim do tratamento com ${medLoad.nome}:',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 56,
                  ),
                  maxFontSize: 56,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 32),
            if (isChecked == false)
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                enablePastDates: false,
              ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        medLoad.periodoNaoInformado = !value;
                      });
                    },
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isChecked == false) {
                            isChecked = true;
                            medLoad.periodoNaoInformado = false;
                          } else if (isChecked == true) {
                            isChecked = false;
                            medLoad.periodoNaoInformado = true;
                          }
                        });
                      },
                      child: Container(
                          color: Colors.transparent,
                          width: 104,
                          height: 50,
                          child: Center(child: Text('Não tenho datas')))),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextButton(
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          setState(() {
                            showAlertDialog(context);
                          });
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.25,
                            MediaQuery.of(context).size.height * 0.07),
                      ),
                      child: const Text('Finalizar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
          hora1: medLoad.hora1,
          hora2: medLoad.hora2,
          hora3: medLoad.hora3,
          hora4: medLoad.hora4,
          hora5: medLoad.hora5,
          hora6: medLoad.hora6,
          hora7: medLoad.hora7,
          hora8: medLoad.hora8,
          dataInicio: medLoad.dataInicio,
          dataFim: medLoad.dataFim,
          diasTratamento: medLoad.diasTratamento,
          id: medLoad.id);

      notificationMed = med;

      List<String?> horariosNull = [
        med.hora1,
        med.hora2,
        med.hora3,
        med.hora4,
        med.hora5,
        med.hora6,
        med.hora7,
        med.hora8,
      ];

      List<String> horarios = horariosNull.whereType<String>().toList()..sort();

      if (Platform.isWindows == false) {
        for (int i = 0; i < horarios.length; i++) {
          NotificationApi.showScheduledNotification(
            title: 'Hora de ${med.nome}!',
            body:
                '${med.quantidade} ${med.tipoQuantidade} de ${med.nome} esperando por você agora :)',
            id: int.parse('${med.id}${horarios.indexOf(horarios[i])}'),
            hour: int.parse(horarios[i].substring(0, 2)),
            minute: int.parse(horarios[i].substring(3, 5)),
          );
          print(
              'notificação #${horarios.indexOf(horarios[i])} agendada para o medicamento ${med.nome} - id: ${med.id}${horarios.indexOf(horarios[i])} - hora: ${int.parse(horarios[i].substring(0, 2))}:${int.parse(horarios[i].substring(3, 5))}');
        }
        print('fim das notificações agendadas do medicamento ${med.nome}');

        sharedPref.remove('med');
        medsLoad.add(med);
        sharedPrefMed.save(medsLoad);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      } else {
        print('Windows não suporta notificação por push');
        sharedPref.remove('med');
        medsLoad.add(med);
        sharedPrefMed.save(medsLoad);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Prosseguir", style: TextStyle(color: Colors.red)),
      onPressed: () {
        confirmar();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Tem certeza?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (Platform.isWindows == false)
            AutoSizeText(
              'Revise as informações passadas sobre o medicamento ${medLoad.nome}:',
              style: TextStyle(fontSize: 18),
              maxLines: 2,
            )
          else
            Text(
              'Revise as informações passadas sobre o medicamento ${medLoad.nome}:',
              style: TextStyle(fontSize: 18),
            ),
          SizedBox(height: 18),
          if (medLoad.dosagem != null)
            Text('Dosagem: ${medLoad.dosagem} ${medLoad.tipoDosagem}')
          else
            Text('Dosagem não informada'),
          const SizedBox(height: 12),
          Text('Quantidade: ${medLoad.quantidade} ${medLoad.tipoQuantidade}'),
          const SizedBox(height: 12),
          Text('Posologia: ${medLoad.posologia}x ao dia'),
          const SizedBox(height: 12),
          Text('Horário(s): ${horarios.join('; ')}'),
          const SizedBox(height: 12),
          if (medLoad.periodoNaoInformado == true)
            Text(
                'Período: de ${DateFormat('dd/MM/yyyy').format(medLoad.dataInicio!)} até ${DateFormat('dd/MM/yyyy').format(medLoad.dataFim!)}, totalizando ${medLoad.diasTratamento} dia(s) de tratamento')
          else
            Text('Período de tratamento não informado'),
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
