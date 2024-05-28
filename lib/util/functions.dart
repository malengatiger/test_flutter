import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

pp(msg) {
  if (kDebugMode) {
    print('${DateTime.now().toIso8601String()} - $msg');
  }
}

showErrorDialog(
    {required String message, String? title, required BuildContext context}) {
  showDialog(context: context, builder: (ctx) {
    return AlertDialog(
      title: Text(title ?? 'Error'), titlePadding: const EdgeInsets.all(8.0), elevation: 16.0,
      icon: const Icon(Icons.error, color: Colors.red, size: 24.0,),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(message),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text('Close'))
      ],
    );
  });
}