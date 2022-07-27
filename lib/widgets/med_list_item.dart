import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:med/models/med.dart';
import 'package:intl/intl.dart';
import 'package:med/models/todbuilder.dart';

class MedListItem extends StatefulWidget {
  MedListItem({
    Key? key,
    required this.med,
    required this.onDelete,
  }) : super(key: key);

  final Med med;
  final Function(Med) onDelete;

  @override
  State<MedListItem> createState() => _MedListItemState();
}

class _MedListItemState extends State<MedListItem> {
  late List<String?> horariosNull = [
    widget.med.hora1,
    widget.med.hora2,
    widget.med.hora3,
    widget.med.hora4,
    widget.med.hora5,
    widget.med.hora6,
    widget.med.hora7,
    widget.med.hora8,
  ];

  late List<String> horarios = horariosNull.whereType<String>().toList()
    ..sort();

  DateTime agora = DateTime.now();

  List<DateTime> horasDT = []; //não chamar essa var!!!

  List<DateTime> horasParaDT() {
    //chamar essa função sempre que quiser a lista de horas em DT
    for (String horas in horarios) {
      horasDT.add(
          DateTime.parse('${DateFormat('yyyy-MM-dd').format(agora)} $horas'));
    }
    horasDT.sort();
    return horasDT;
  }

  late TimeOfDay tempoFaltante = TimeOfDayBuilder().timeUntil(horasParaDT());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (Med) {
                widget.onDelete(widget.med);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _MedInfo(context),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Próxima dose (desde que a aplicação foi aberta) em: ${tempoFaltante.format(context)}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.med.nome!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _MedInfo(BuildContext context) {
    return new AlertDialog(
      title: Text('Informações do remédio ${widget.med.nome}'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.med.dosagem != null)
            Text('Dosagem: ${widget.med.dosagem} ${widget.med.tipoDosagem}')
          else
            Text('Dosagem não informada'),
          const SizedBox(height: 12),
          Text(
              'Quantidade: ${widget.med.quantidade} ${widget.med.tipoQuantidade}'),
          const SizedBox(height: 12),
          Text('Posologia: ${widget.med.posologia}x ao dia'),
          const SizedBox(height: 12),
          Text('Horário(s): ${horarios.join('; ')}'),
          const SizedBox(height: 12),
          if (widget.med.diasTratamento != 0)
            Text(
                'Período: de ${DateFormat('dd/MM/yyyy').format(widget.med.dataInicio!)} até ${DateFormat('dd/MM/yyyy').format(widget.med.dataFim!)}, totalizando ${widget.med.diasTratamento} dia(s) de tratamento')
          else
            Text('Período de tratamento não informado'),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
