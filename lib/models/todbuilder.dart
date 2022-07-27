import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeOfDayBuilder {
  int? amount;
  TimeOfDay? time;
  List<TimeOfDay>? horarios;

  List<TimeOfDay> selectGreater = [];

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

  TimeOfDay timeUntil(List<DateTime> listHoras) {
    listHoras.sort();
    print(listHoras);
    DateTime agora = DateTime.now();
    //String agoraFormat = format.format(DateTime.now());
    for (DateTime horas in listHoras) {
      if (horas.isAfter(agora)) {
        Duration diff = horas.difference(agora);
        int hours = diff.inHours;
        int minutes = diff.inMinutes % 60;
        print('${hours}h${minutes}');
        TimeOfDay time = TimeOfDay(hour: hours, minute: minutes);
        selectGreater.add(time);
      } else if (horas.isBefore(agora)) {
        Duration diff = horas.difference(agora);
        int minutes = diff.inMinutes % 60 == 60 ? 0 : diff.inMinutes % 60;
        if (minutes == 0) {
          int hours = diff.inHours + 24;
          print('${hours}h${minutes}');
          TimeOfDay time = TimeOfDay(hour: hours, minute: minutes);
          selectGreater.add(time);
        } else {
          int hours = diff.inHours + 24 - 1;
          print('${hours}h${minutes}');
          TimeOfDay time = TimeOfDay(hour: hours, minute: minutes);
          selectGreater.add(time);
        }
      }
    }
    TimeOfDay until = selectGreater
        .reduce((curr, next) => curr.hour < next.hour ? curr : next);
    if (until.hour >= 24) {
      until = TimeOfDay(hour: until.hour, minute: until.minute);
      return until;
    } else {
      return until;
    }
  }
}
