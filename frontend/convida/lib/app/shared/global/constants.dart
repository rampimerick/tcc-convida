library my_prj.constants;

import 'package:flutter/material.dart';

const String kAppVersion = "1.6.0";
const String kURL = "http://192.168.100.111:8080";
//const String kURL = "http://192.168.0.106:8080";
//const String kURL = "https://app-convida.ufpr.br";

//String URL = "http://192.168.0.102:8080";
//String URL = "http://10.0.2.2:8080";
//String URL = "http://192.168.0.5:8080";
//String URL = "http://200.17.200.59:8080";

//String Sizes:
const int kStringSizeSmall = 50;
const int kStringSizeNormal = 100;
const int kStringSizeBig = 300;
const int kStringSizeDate = 10;

//Padding:
const double kDefaultPadding = 20.0;

//Colors:
const Color kPrimaryColor = Color(0xFFFF4933);
const Color kSecondaryColor = Color(0xFF255D83);

//Shadow:
final kDefaultShadow = BoxShadow(
    offset: Offset(5, 5),
    blurRadius: 10.0,
    color: Color(0xFFE9E9E9).withOpacity(0.56));

//Event
//const String kHealthName = "Saúde e Bem-estar";
const String kEventIcon = "assets/icons/events.png";

//Saúde e Bem-estar
const String kHealthName = "Saúde e Bem-estar";
const String kHealthIcon = "assets/icons/health.png";
const String kHealthImage = "assets/images/1.jpg";
const int eventHealthColor = 0xFFF98F9B;
const Color kHealthColor = Color(0xFFF98F9B);

//Esporte e Lazer
const String kSportName = "Esporte e Lazer";
const String kSportIcon = "assets/icons/sports.png";
const String kSportImage = "assets/images/2.jpg";
const int eventSportColor = 0xFF94C597;
const Color kSportColor = Color(0xFF94C597);

//Festas e Comemorações
const String kPartyName = "Festas e Comemorações";
const String kPartyIcon = "assets/icons/party.png";
const String kPartyImage = "assets/images/3.jpg";
const int eventPartyColor = 0xFF9889CE;
const Color kPartyColor = Color(0xFF9889CE);

//Arte e Cultura
const String kArtName = "Arte e Cultura";
const String kArtIcon = "assets/icons/art.png";
const String kArtImage = "assets/images/4.jpg";
const int eventArtColor = 0xFFEA6CA0;
const kArtColor = Color(0xFFEA6CA0);

//Fé e Espiritualidade
const String kFaithName = "Fé e Espiritualidade";
const String kFaithIcon = "assets/icons/faith.png";
const String kFaithImage = "assets/images/5.jpg";
const int eventFaithColor = 0xFFEAC426;
const Color kFaithColor = Color(0xFFEAC426);

//Acâdemico e Profissional
const String kGraduationName = "Acadêmico e Profissional";
const String kGraduationIcon = "assets/icons/graduation.png";
const String kGraduationImage = "assets/images/6.jpg";
const int eventGraduationColor = 0xFF6C9FDD;
const Color kGraduationColor = Color(0xFF6C9FDD);

//Outros
const String kOtherName = "Outros";
const String kOtherIcon = "assets/icons/others.png";
const String kOtherImage = "assets/images/7.jpg";
const int eventOtherColor = 0xFFBABABA;
const Color kOtherColor = Color(0xFFBABABA);
