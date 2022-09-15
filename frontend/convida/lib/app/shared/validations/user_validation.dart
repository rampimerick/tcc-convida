library my_prj.validations.user;

import 'package:convida/app/shared/validations/date_validation.dart';
import 'package:intl/intl.dart';

String nameValidation(value, name) {
  String expression = r"^[A-Za-zá àâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]{2,25}$";
  RegExp _nameValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com seu $name';
  } else if (value.isEmpty) {
    return 'Favor entre com seu $name';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > 25) {
    return 'Max. 25 caracteres';
  } else if (_nameValidator.hasMatch(value)) {
    return null;
  } else
    return 'Possuí caracter inválido';
}

String grrValidation(value) {
  String expression = r"^[gG]{1}[rR]{2}[0-9]{8}";
  RegExp _grrValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com seu GRR';
  } else if (value.isEmpty) {
    return 'Favor entre com seu GRR';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 11) {
    return "Favor entre com seu GRR";
  } else if (_grrValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possuí caracter inválido';
  }
}

String birthValidation(value) {
  if (value == null) {
    return 'Favor entre com a Data de Nascimento';
  } else if (value.isEmpty) {
    return 'Favor entre com a Data de Nascimento';
  } else if (value.length < 10) {
    return 'Favor entre com a Data de Nascimento';
  } else {
    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateTime parsedDate = dateFormat.parse(value);
    bool valid = isValidDate(value);
    var diffDuration = DateTime.now().difference(parsedDate);
    if (!valid) {
      return "Data inválida";
    } else if (parsedDate.year < 1900) {
      return "Data muito Antiga";
    } else if (parsedDate.compareTo(DateTime.now()) > 0) {
      return "Data é Futura";
    } else if (diffDuration < Duration(hours: 105192)) {
      //* 105.192 hours is equals to 12 years.
      return "Menor de 12 anos";
    } else {
      return null;
    }
  }
}

String emailValidation(value) {
  String expression = r"^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$";
  RegExp _emailValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com seu E-mail';
  } else if (value.isEmpty) {
    return 'Favor entre com seu E-mail';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length > 50) {
    return 'Max. 50 caracteres';
  } else if (!value.contains("@")) {
    return 'Está faltando "@"';
  } else if (!value.contains(".")) {
    return 'Está faltando "."';
  } else if (_emailValidator.hasMatch(value)) {
    return null;
  } else
    return 'E-mail inválido';
}

String passwordValidation(value, password) {
  String expression =  r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,50}$';
  RegExp _userPasswordValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com sua Senha';
  } else if (value.isEmpty) {
    return 'Favor entre com sua Senha';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains(' ')) {
    return 'Contém espaço';
  } else if (value.length < 4) {
    return 'Min. 4 caracteres';
  } else if (value.length > 30) {
    return 'Max. 30 caracteres';
  }
  // } else if (_userPasswordValidator.hasMatch(value)) {
  //     return null;
  // } 
  
  else
    return null;
}
