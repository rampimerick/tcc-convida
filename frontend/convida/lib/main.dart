import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:convida/app/screens/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  initializeDateFormatting("pt_BR", null);
  await Firebase.initializeApp();
  runApp(AppWidget());
}
