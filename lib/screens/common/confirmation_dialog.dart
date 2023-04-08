import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  String title = "Atenção",
  String content = "Você realmente deseja executar essa operação?",
  String affirmativeActionTitle = "Sim",
  String negativeActionTitle = "Não",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(negativeActionTitle),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmativeActionTitle.toUpperCase(),
              style: const TextStyle(
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
    },
  );
}
