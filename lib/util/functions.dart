import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

Color getFontColorForBackground(Color background) {
  return (background.computeLuminance() > 0.179)? Colors.black : Colors.white;
}

bool isColorDark(Color color) {
  if (color.computeLuminance() > 0.179) {
    return false;
  }
  return true;
}
String getFormattedUnixDateLong(int unixDate) {
  var date = DateTime.fromMillisecondsSinceEpoch(unixDate);
  final DateFormat formatter = DateFormat('EEEE, yyyy-MMMM-dd HH:mm');
  final String formatted = formatter.format(date);
  return formatted;
}
String getFormattedUnixDateMedium(int unixDate) {
  var date = DateTime.fromMillisecondsSinceEpoch(unixDate);
  final DateFormat formatter = DateFormat('yyyy-MMM-dd HH:mm');
  final String formatted = formatter.format(date);
  return formatted;
}
String getFormattedUnixDateShort(int unixDate) {
  var date = DateTime.fromMillisecondsSinceEpoch(unixDate);
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  final String formatted = formatter.format(date);
  return formatted;
}