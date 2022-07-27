import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:med/models/med.dart';

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

  late List<String> horarios = horariosNull.whereType<String>().toList();

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
                    'Próxima dose em:',
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
          const SizedBox(height: 8),
          Text(
              'Quantidade: ${widget.med.quantidade} ${widget.med.tipoQuantidade}'),
          const SizedBox(height: 8),
          Text('Horário(s): ${horarios.join(', ')}'),
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
