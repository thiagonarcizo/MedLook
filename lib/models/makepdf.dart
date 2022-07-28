import 'package:flutter/services.dart';
import 'package:med/models/med.dart';
import 'package:med/models/person.dart';
import 'package:med/repositories/data.dart';
import 'package:med/repositories/meddata.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

class MakePdf {
  Future<Uint8List> makePdf(
      {required Person person, required List<Med> meds}) async {
    final pdf = Document();
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/launcher/foreground.png'))
            .buffer
            .asUint8List());
    pdf.addPage(
      Page(build: (context) {
        return Column(
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
                'MEDICAMENTOS:',
                style: Theme.of(context).header4,
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(20),
            ),
            Table(
              tableWidth: TableWidth.max,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: PdfColors.black),
              children: [
                if (meds.isEmpty)
                  TableRow(
                    children: [
                      Expanded(
                        child: PaddedText('Nenhum medicamento cadastrado'),
                        flex: 2,
                      ),
                    ],
                  )
                else
                  for (Med med in meds)
                    TableRow(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '${med.nome}',
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText(
                              "${med.dosagem?.toString() ?? 'Sem dosagem'} ${med.tipoDosagem ?? ''}"),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText(
                              "${med.quantidade} ${med.tipoQuantidade}"),
                          flex: 2,
                        ),
                        Expanded(
                          child: PaddedText("${med.posologia}x ao dia"),
                          flex: 1,
                        ),
                        Expanded(
                          child: med.periodoNaoInformado
                              ? PaddedText(
                                  'Período: de ${DateFormat('dd/MM/yyyy').format(med.dataInicio!)} até ${DateFormat('dd/MM/yyyy').format(med.dataFim!)}, totalizando ${med.diasTratamento} dia(s) de tratamento')
                              : PaddedText(
                                  'Período de tratamento não informado'),
                          flex: 2,
                        ),
                      ],
                    ),
              ],
            ),
            Padding(
              child: Text(
                "obrigado por usar medlook :)",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
          ],
        );
      }),
    );
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
