import 'package:convida/app/shared/global/constants.dart';
import 'package:flutter/material.dart';

//Definição da Cor desejada pelo Cliente:
Map<int, Color> colorBlue = {
  50: Color.fromRGBO(41, 84, 146, .1),
  100: Color.fromRGBO(41, 84, 146, .2),
  200: Color.fromRGBO(41, 84, 146, .3),
  300: Color.fromRGBO(41, 84, 146, .4),
  400: Color.fromRGBO(41, 84, 146, .5),
  500: Color.fromRGBO(41, 84, 146, .6),
  600: Color.fromRGBO(41, 84, 146, .7),
  700: Color.fromRGBO(41, 84, 146, .8),
  800: Color.fromRGBO(41, 84, 146, .9),
  900: Color.fromRGBO(41, 84, 146, 1),
};
final blueColor = new MaterialColor(kSecondaryColor.value, colorBlue);

//Definição do Tema:
ThemeData blueTheme =
    ThemeData(primarySwatch: blueColor, brightness: Brightness.light);
