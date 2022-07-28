import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayConverter on TimeOfDay {
  String to24h(BuildContext context) {
    try {
      int hour = int.parse(this.hour.toString().padLeft(2, '0'));
      int minute = int.parse(this.minute.toString().padLeft(2, '0'));
      List<int> timeList = [hour, minute];
      TimeOfDay horaTOD = TimeOfDay(hour: timeList[0], minute: timeList[1]);
      String tempo = horaTOD.format(context);
      var df = DateFormat("h:mm a");
      var dt = df.parse(tempo);
      return '${DateFormat('HH:mm').format(dt)}';
    } catch (e) {
      return this.format(context);
    }
  }
}
