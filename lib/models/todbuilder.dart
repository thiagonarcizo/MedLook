import 'package:flutter/material.dart';

class TimeOfDayBuilder {
  int? amount;
  TimeOfDay? time;
  List<TimeOfDay>? horarios;

  TimeOfDayBuilder({this.amount, this.time, this.horarios});

  TimeOfDay timeFix() {
    int hour = int.parse(this.time!.hour.toString().padLeft(2, '0'));
    int minute = int.parse(this.time!.minute.toString().padLeft(2, '0'));
    List<int> timeList = [hour, minute];
    if (hour + (24 / this.amount!).round() > 23) {
      timeList[0] = hour + (24 / this.amount!).round() - 24;
      return TimeOfDay(hour: timeList[0], minute: timeList[1]);
    } else {
      timeList[0] = hour + (24 / this.amount!).round();
      return TimeOfDay(hour: timeList[0], minute: timeList[1]);
    }
  }

  List<String> timeSort(BuildContext context) {
    List<String> horariosFormat = [];
    for (TimeOfDay horas in this.horarios!) {
      horariosFormat.add(horas.format(context));
    }
    horariosFormat.sort();
    return horariosFormat;
  }
}
