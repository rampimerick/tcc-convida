import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/models/login.dart';
import 'package:convida/app/shared/models/mobx/signup.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/user_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/global/constants.dart';
import 'package:mobx/mobx.dart';
part 'signup_controller.g.dart';

class SignupController = _SignupControllerBase with _$SignupController;

abstract class _SignupControllerBase with Store {
  var signup = Signup();
  String _url = kURL;

  @observable
  bool loading = false;

  @computed
  bool get isValid {
    return true;
    //Validations..
  }

  String validateName() {
    return nameValidation(signup.name, "nome");
  }

  String validadeLastName() {
    return nameValidation(signup.lastName, "sobrenome");
  }

  String validadeGrr() {
    return grrValidation(signup.grr);
  }

  String validadeEmail() {
    return emailValidation(signup.email);
  }

  String validadeBirth() {
    return birthValidation(signup.birth);
  }

  String validadePassword() {
    return passwordValidation(signup.password, signup.confirmPassword);
  }

  String validadeConfirmPassword() {
    return passwordValidation(signup.confirmPassword, signup.password);
  }

  Future<int> checkEmail() async {
    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String email = signup.email;
    int statusE = await http
        .get(Uri.parse("$_url/users/checkemail/$email"), headers: mapHeaders)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (response.body.compareTo("true") == 0) {
        //print("Email válido");
        return 200;
      } else {
        loading = false;
        //print("Email Inválido");
        return 500;
      }
    });
    return statusE;
  }

  Future<int> checkGrr() async {
    loading = true;
    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String grr = signup.grr;
    //print(grr);

    int statusC = await http
        .get(Uri.parse("$_url/users/$grr"), headers: mapHeaders)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if ((statusCode == 200) || (statusCode == 201)) {
        //Return 500 because already exist a user with this GRR
        loading = false;
        return 500;
      } else {
        return 200;
      }
    });
    //print("StatusCode = $statusC");
    return statusC;
  }

  bool checkAll(BuildContext context) {
    String error;

    //*Name
    error = nameValidation(signup.name, "nome");
    if (error != null) {
      showError("Nome inválido", error, context);
      return false;
    }

    //*LastName
    error = nameValidation(signup.lastName, "sobrenome");
    if (error != null) {
      showError("Sobrenome inválido", error, context);
      return false;
    }

    //*GRR
    error = grrValidation(signup.grr);
    if (error != null) {
      showError("GRR inválido", error, context);
      return false;
    }

    //*Birthday
    error = birthValidation(signup.birth);
    if (error != null) {
      showError("Data de Nascimento inválida", error, context);
      return false;
    }

    //*Email
    error = emailValidation(signup.email);
    if (error != null) {
      showError("E-mail Inválido", error, context);
      return false;
    }

    //*Password
    error = passwordValidation(signup.password, signup.confirmPassword);
    if (error != null) {
      showError("Senha Inválida", error, context);
      return false;
    }

    //*Confirm Password
    error = passwordValidation(signup.confirmPassword, signup.password);
    if (error != null) {
      showError("Confirmação de Senha inválida", error, context);
      return false;
    }

    return true;
  }

  Future<int> postNewUser({String dateUser, BuildContext context}) async {
    User u = new User(
        login: signup.grr,
        name: signup.name, //_userFirstNameController.text,
        lastName: signup.lastName,
        password: signup.password,
        email: signup.email,
        birth: dateUser);

    String userJson = json.encode(u.toJson());
    //print("Novo Json com MOBX: $userJson");

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    int code;

    try {
      code = await http
          .post(Uri.parse("$_url/users"), body: userJson, headers: mapHeaders)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if ((statusCode == 200) || (statusCode == 201)) {
          //print("Post User Success!");
          return statusCode;
        } else {
          //print("Post User Error: $statusCode");
          return statusCode;
        }
      });
    } catch (e) {
      showError("Erro desconhecido capturado", "Erro: $e", context);
    }
    loading = false;
    return code;
  }

  Future<int> postLoginUser({BuildContext context}) async {
    final _save = FlutterSecureStorage();

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    AccountCredentials l = new AccountCredentials(
      username: signup.grr,
      password: signup.password,
    );

    String loginJson = json.encode(l.toJson());

    int sts;
    try {
      sts = await http
          .post(Uri.parse("$_url/login"), body: loginJson, headers: mapHeaders)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        //print("-------------------------------------------------------");
        //print("Request on: $_url/login");
        //print("Status Code: ${response.statusCode}");
        //print("Posting User Login...");

        if ((statusCode == 200) || (statusCode == 201)) {
          var j = json.decode(response.body);
          //print("Saving..");

          _save.write(key: "token", value: j["token"]);
          _save.write(key: "user", value: signup.grr);
          //print("-------------------------------------------------------");
          return statusCode;
        } else {
          //print("Error Token");
          //print("-------------------------------------------------------");
          return statusCode;
        }
      });
    } catch (e) {
      showError(
          "Erro desconhecido ao fazer login automático", "Erro: $e", context);
    }

    final token = await _save.read(key: "token");

    Map<String, String> mapHeadersToken = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    if (sts == 200 || sts == 201) {
      try {
        String id = signup.grr;
        User user = await http
            .get(Uri.parse("$_url/users/$id"), headers: mapHeadersToken)
            .then((http.Response response) {
          final int statusCode = response.statusCode;

          //print("-------------------------------------------------------");
          //print("Request on: $_url/users/$id");
          //print("Status Code: ${response.statusCode}");
          //print("Loading User Profile...");
          //print("-------------------------------------------------------");

          if ((statusCode == 200) || (statusCode == 201)) {
            return User.fromJson(jsonDecode(response.body));
          } else {}
        });

        _save.write(key: "name", value: "${user.name}");
        _save.write(key: "email", value: "${user.email}");
        _save.write(key: "lastName", value: "${user.lastName}");
      } catch (e) {
        showError(
            "Erro desconhecido ao salvar Credenciais", "Erro: $e", context);
      }
    }
    return sts;
  }
}
