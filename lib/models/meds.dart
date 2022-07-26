import 'package:med/models/med.dart';

class Meds {
  List<Med>? meds = [];

  Meds({this.meds = const []});

  add(Med med) {
    meds!.add(med);
  }

  clear() {
    meds!.clear();
  }

  Meds.fromJson(Map<String, dynamic> json) : meds = json['meds'];

  Map<String, dynamic> toJson() => {
        'meds': meds,
      };
}
