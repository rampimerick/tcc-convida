import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/models/login.dart';
import 'package:convida/app/shared/models/mobx/profile.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/user_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/global/constants.dart';
import 'package:intl/intl.dart';

import 'package:mobx/mobx.dart';
part 'alter_profile_controller.g.dart';

class AlterProfileController = _AlterProfileControllerBase
    with _$AlterProfileController;

abstract class _AlterProfileControllerBase with Store {
  var profile = Profile();
  String _url = kURL;

  @observable
  bool loading = false;

  @computed
  bool get isValid {
    return ((validateName() == null) &&
        (validadeLastName() == null) &&
        (validadeEmail() == null) &&
        (validadePassword() == null));
  }

  String validateName() {
    return nameValidation(profile.name, "nome");
  }

  String validadeLastName() {
    return nameValidation(profile.lastName, "sobrenome");
  }

  String validadeEmail() {
    return emailValidation(profile.email);
  }

  String validadePassword() {
    return passwordValidation(profile.password, null);
  }

  String validadeNewPassword() {
    return passwordValidation(profile.newPassword, profile.confirmPassword);
  }

  String validadeBirth() {
    return birthValidation(profile.birth);
  }

  bool checkAll(BuildContext context) {
    String error;

    //*Name
    error = nameValidation(profile.name, "nome");
    if (error != null) {
      showError("Nome inválido", error, context);
      return false;
    }

    //*LastName
    error = nameValidation(profile.lastName, "sobrenome");
    if (error != null) {
      showError("Sobrenome inválido", error, context);
      return false;
    }

    //*Birthday
    error = birthValidation(profile.birth);
    if (error != null) {
      showError("Data de Nascimento inválida", error, context);
      return false;
    }

    //*Email
    error = emailValidation(profile.email);
    if (error != null) {
      showError("E-mail Inválido", error, context);
      return false;
    }

    //*Password
    /* error = passwordValidation(profile.password, null);
    if (error != null) {
      showError("Senha Inválida", error, context);
      return false;
    } */

    //if (profile.newPassword != null) {
    //*Confirm Password
    /* error = passwordValidation(profile.newPassword, profile.confirmPassword);
      if (error != null) {
        showError("Confirmação de Senha inválida", error, context);
        return false;
      } */

    //*Confirm Password
    /* error = passwordValidation(profile.confirmPassword, profile.newPassword);
      if (error != null) {
        showError("Confirmação de Senha inválida", error, context);
        return false;
      }
    } */

    return true;
  }

  Future<bool> getProfile({
    User user,
    BuildContext context,
  }) async {
    try {
      DateTime parsedBirth;
      final DateFormat formatter = new DateFormat("dd/MM/yyyy");

      profile.changeName(user.name);
      profile.lastName = user.lastName;
      profile.email = user.email;

      if (user.birth != null) {
        parsedBirth = DateTime.parse(user.birth);
        profile.birth = formatter.format(parsedBirth);
      }

      return true;
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
      return false;
    }
  }

  Future<bool> passCheck({User user, BuildContext context}) async {
    loading = true;
    final _save = FlutterSecureStorage();
    final _token = await _save.read(key: "token");

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $_token"
    };

    AccountCredentials ac = new AccountCredentials(
        password: profile.password, username: user.login);
    String acJson = jsonEncode(ac);
    bool correct;

    try {
      correct = await http
          .put(Uri.parse("$_url/users/checkpass"), body: acJson, headers: mapHeaders)
          .then((http.Response response) {
        // final int statusCode = response.statusCode;


        if ((response.statusCode == 200) || (response.statusCode == 201)) {
          if (response.body == "true")
            return true;
          else {
            loading = false;
            return false;
          }
        } else if (response.statusCode == 401) {
          loading = false;
          showError(
              "Erro 401", "Não autorizado, favor logar novamente", context);
          return false;
        } else if (response.statusCode == 404) {
          loading = false;
          showError(
              "Erro 404", "Evento ou usuário não foi encontrado", context);
          return false;
        } else if (response.statusCode == 500) {
          loading = false;
          showError("Erro 500",
              "Erro no servidor, favor tente novamente mais tarde", context);
          return false;
        } else {
          loading = false;
          showError("Erro Desconhecido", "StatusCode: ${response.statusCode}",
              context);
          return false;
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
      return false;
    }

    return correct;
  }

  Future<int> putUser(
      {bool isSwitch, User user, String dateUser, BuildContext context}) async {
    final _save = FlutterSecureStorage();
    final _token = await _save.read(key: "token");
    final userId = await _save.read(key: "userId");

    User u;

    if (isSwitch) {
      u = new User(
          login: user.login,
          name: profile.name,
          lastName: profile.lastName,
          email: profile.email,
          birth: dateUser);
    } else {
      u = new User(
          login: user.login,
          name: profile.name,
          lastName: profile.lastName,
          email: profile.email,
          birth: dateUser);
    }

    String userJson = json.encode(u.toJson());

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $_token"
    };

    int code;

    try {
      code = await http
          .put(Uri.parse("$_url/users/$userId"), body: userJson, headers: mapHeaders)
          .then((http.Response response) {
        final int statusCode = response.statusCode;


        if (statusCode == 204) {
          _save.write(key: "user", value: user.login);
          _save.write(key: "name", value: profile.name);
          _save.write(key: "email", value: profile.email);
          _save.write(key: "lastName", value: profile.lastName);
          return statusCode;
        } else {
          return statusCode;
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
    }
    loading = false;
    return code;
  }
}
