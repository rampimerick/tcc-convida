import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

Map<int, Color> colorOrange = {
  50: Color.fromRGBO(255, 73, 51, .1),
  100: Color.fromRGBO(255, 73, 51, .2),
  200: Color.fromRGBO(255, 73, 51, .3),
  300: Color.fromRGBO(255, 73, 51, .4),
  400: Color.fromRGBO(255, 73, 51, .5),
  500: Color.fromRGBO(255, 73, 51, .6),
  600: Color.fromRGBO(255, 73, 51, .7),
  700: Color.fromRGBO(255, 73, 51, .8),
  800: Color.fromRGBO(255, 73, 51, .9),
  900: Color.fromRGBO(255, 73, 51, 1),
};
final orangeColor = new MaterialColor(kPrimaryColor.value, colorOrange);

//Definição do Tema:
ThemeData orangeTheme =
    ThemeData(primarySwatch: orangeColor, brightness: Brightness.light);
