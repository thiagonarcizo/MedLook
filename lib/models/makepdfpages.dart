import 'package:flutter/services.dart';
import 'package:med/models/med.dart';
import 'package:med/models/person.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

class MakePdfPages {
  Future<Uint8List> makePdf(
      {required Person person, required List<Med> meds}) async {
    final pdf = Document();
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/launcher/foreground.png'))
            .buffer
            .asUint8List());
    for (Med med in meds) {
      pdf.addPage(
        Page(build: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          '${person.nome!}, ${person.idade!.toString()} anos | sexo ${person.sexo} | ${person.altura!.toString()} cm | ${person.peso!.toString()} kg',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(imageLogo),
                  )
                ],
              ),
              Padding(
                child: Text(
                  'MEDICAMENTO: ${med.nome} ${med.dosagem ?? ''}${med.tipoDosagem ?? ''}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: 85, bottom: 32),
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '- Quantidade: ${med.quantidade} ${med.tipoQuantidade}',
                        style: Theme.of(context).header1),
                    SizedBox(height: 16),
                    Text('- Posologia: ${med.posologia}x ao dia',
                        style: Theme.of(context).header1),
                    SizedBox(height: 16),
                    med.periodoNaoInformado
                        ? Text(
                            '- Período: de ${DateFormat('dd/MM/yyyy').format(med.dataInicio!)} até ${DateFormat('dd/MM/yyyy').format(med.dataFim!)},\ntotalizando ${med.diasTratamento} dia(s) de tratamento',
                            style: Theme.of(context).header1)
                        : Text('Período de tratamento não informado',
                            style: Theme.of(context).header1),
                  ]),
            ],
          );
        }),
      );
    }
    return pdf.save();
  }

  Widget PaddedText(
    final String text, {
    final TextAlign align = TextAlign.center,
  }) =>
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          text,
          textAlign: align,
        ),
      );
}
