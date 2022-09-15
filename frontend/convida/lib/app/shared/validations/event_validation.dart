library my_prj.validations.event;

import 'package:intl/intl.dart';

import 'date_validation.dart';

const MAX_STRING = 100;

String nameValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,' +
          MAX_STRING.toString() +
          r'}$';

  RegExp _nameValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com o nome do Evento';
  } else
  if (value.isEmpty) {
    return 'Favor entre com o nome do Evento';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > MAX_STRING) {
    return 'Max. $MAX_STRING caracteres';
  } else if (_nameValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String targetValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,' +
          MAX_STRING.toString() +
          r'}$';
  RegExp _targetValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com o Público Alvo';
  } else
  if (value.isEmpty) {
    return 'Favor entre com o Público Alvo';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > MAX_STRING) {
    return 'Max. $MAX_STRING caracteres';
  } else if (_targetValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String descriptionValidation(value) {
  // String expression =
  //     r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,300}$';

  //RegExp _descValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com uma breve descrição';
  } else
  if (value.isEmpty) {
    return 'Favor entre com uma breve descrição';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > 300) {
    return 'Max. 300 caracteres';
  }
  // RZR
  return null;
  /*} else if (_descValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }*/
}

String addressValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,' +
          MAX_STRING.toString() +
          r'}$';
  RegExp _addressValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com um Endereço';
  } else
  if (value.isEmpty) {
    return 'Favor entre com um Endereço';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > MAX_STRING) {
    return 'Max. $MAX_STRING caracteres';
  } else if (_addressValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String complementValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{0,' +
          MAX_STRING.toString() +
          r'}$';
  RegExp _complementValidator = RegExp(expression);

  if (value == null) {
    return null;
  } else
  if (value.isEmpty) {
    return null;
  } else if (value.length > MAX_STRING) {
    return 'Max. $MAX_STRING caracteres';
  }
  if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  }
  if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  }
  if (_complementValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String linkValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{2,300}$';
  RegExp _eventLinkValidator = RegExp(expression);

  if (value == null) {
    return 'Favor entre com o Link ou E-mail';
  } else
  if (value.isEmpty) {
    return 'Favor entre com o Link ou E-mail';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 2) {
    return 'Min. 2 caracteres';
  } else if (value.length > 300) {
    return 'Max. 300 caracteres';
  } else if (_eventLinkValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String reportValidation(value) {
  String expression =
      r'^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ !@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]{3,280}$';
  RegExp _reportValidator = RegExp(expression);

  if (value == null) {
    return 'Favor justifique sua Denúncia';
  } else
  if (value.isEmpty) {
    return 'Favor justifique sua Denúncia';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains('  ')) {
    return 'Contém espaços desnecessários';
  } else if (value.length < 3) {
    return 'Min. 3 caracteres';
  } else if (value.length > 280) {
    return 'Max. 280 caracteres';
  } else if (_reportValidator.hasMatch(value)) {
    return null;
  } else {
    return 'Possui caracter inválido';
  }
}

String dateValidation(value, String date) {
  if (value == null) {
    return 'Favor entre com a Data $date';
  } else
  if (value.isEmpty) {
    return 'Favor entre com a Data $date';
  } else if (value.length < 10) {
    return 'Favor entre com a Data $date';
  } else {
    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateTime parsedDate = dateFormat.parse(value);
    //print(parsedDate);
    bool valid = isValidDate(value);
    if (!valid) {
      return "Data inválida";
    } else if (parsedDate.compareTo(DateTime.now()) > 0) {
      return null;
    } else if (parsedDate.year == DateTime.now().year) {
      if (parsedDate.month == DateTime.now().month) {
        if (parsedDate.day == DateTime.now().day) {
          //Today
          return null;
        }
        return "Data já passou!";
      }
      return "Data já passou!";
    } else {
      return "Data já passou!";
    }
  }
}

String hourValidation(value, String hour) {
  if (value == null) {
    return 'Favor entre com a Hora de $hour';
  } else
  if (value.isEmpty) {
    return 'Favor entre com a Hora de $hour';
  } else if (value.length < 5) {
    return 'Favor entre com a Hora de $hour';
  } else {
    bool valid = isValidHour(value);
    if (!valid) {
      return "Hora de $hour inválida";
    } else {
      return null;
    }
  }
}

String dateValidationOccurrences(value, String date) {

  if(value.isEmpty){
    return null;
  } else if (value.length < 10) {
    return 'Entre com a data $date';
  } else {
    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateTime parsedDate = dateFormat.parse(value);
    bool valid = isValidDate(value);
    if (!valid) {
      return "Data inválida";
    } else if (parsedDate.compareTo(DateTime.now()) > 0) {
      return null;
    } else if (parsedDate.year == DateTime.now().year) {
      if (parsedDate.month == DateTime.now().month) {
        if (parsedDate.day == DateTime.now().day) {
          //Today
          return null;
        }
        return "Data já passou!";
      }
      return "Data já passou!";
    } else {
      return "Data já passou!";
    }
  }
}
