library my_prj.validations.login;

String userValidation(value) {
  //String expression = r"^[gG]{1}[rR]{2}[0-9]{8}";
  //RegExp _grrValidator = RegExp(expression);


  if (value == null) {
    return 'Favor entre com o seu login';
  } else if (value.isEmpty) {
    return 'Favor entre com o seu login';
  } else if (value.startsWith(' ')) {
    return 'Inicia com espaço';
  } else if (value.contains(' ')) {
    return 'Contém espaço';
  } 
  
  else {
    return null;
  }
}

String passwordValidation(value) {
  //String expression = r"^[a-zA-Z0-9_@$!%&-]{4,18}$";
  //RegExp _userPasswordValidator = RegExp(expression);

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

String recoveryEmailValidation(value) {
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
  } else if (_emailValidator.hasMatch(value)) {
    return null;
  } else
    return 'E-mail inválido';
}
