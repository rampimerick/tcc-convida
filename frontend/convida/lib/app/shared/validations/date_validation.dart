library my_prj.validations.date;

import 'package:intl/intl.dart';

//*Date Format > dd/MM/YYYY

bool isValidDate(String input) {
  try {
    final date = new DateFormat("dd/MM/yyyy").parse(input);
    final originalFormat = toDateFormat(date);
    return input == originalFormat;
  } catch (e) {
    throw Exception(e);
  }
}

String toDateFormat(DateTime dateTime) {
  final y = dateTime.year.toString().padLeft(4, '0');
  final m = dateTime.month.toString().padLeft(2, '0');
  final d = dateTime.day.toString().padLeft(2, '0');
  return "$d/$m/$y";
}

isValidHour(String input) {
  try {
    final hour = new DateFormat("HH:mm").parse(input);
    final originalFormat = toHourFormat(hour);
    return input == originalFormat;
  } catch (e) {
    throw Exception(e);
  }
}

String toHourFormat(DateTime dateTime) {
  final h = dateTime.hour.toString().padLeft(2, '0');
  final m = dateTime.minute.toString().padLeft(2, '0');
  return "$h:$m";
}
