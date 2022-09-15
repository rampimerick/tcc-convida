import 'package:convida/app/shared/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:convida/app/shared/theme/orange_theme.dart';
import 'package:convida/app/shared/routes/routes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Make the app without "Debug warning" on screen
        debugShowCheckedModeBanner: false,
        title: "UFPRConVIDA",
        theme: orangeTheme,
        initialRoute: '/main',
        routes: routes);
  }
}
