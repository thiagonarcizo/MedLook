import 'package:flutter/material.dart';
import 'package:med/models/makepdf.dart';
import 'package:med/models/makepdfpages.dart';
import 'package:med/models/med.dart';
import 'package:med/models/person.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfView extends StatelessWidget {
  PdfView({required this.person, required this.meds, Key? key})
      : super(key: key);

  final Person person;
  final List<Med> meds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF dos medicamentos'),
      ),
      body: PdfPreview(
        build: (context) => meds.length > 3
            ? MakePdfPages().makePdf(person: person, meds: meds)
            : MakePdf().makePdf(person: person, meds: meds),
        canChangePageFormat: false,
        canDebug: false,
      ),
    );
  }
}
