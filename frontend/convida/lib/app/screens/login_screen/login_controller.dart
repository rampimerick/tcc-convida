import 'package:convida/app/shared/models/login.dart';
import 'package:convida/app/shared/models/mobx/login.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/uri_utils.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/login_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  Login login = new Login();
  Login recovery = new Login();

  @observable
  bool loading = false;

  String validateUser() {
    return userValidation(login.user);
  }

  String validatePassword() {
    return passwordValidation(login.password);
  }

  bool validadeLogin(BuildContext context) {
    String ok = validateUser();
    //print(ok);
    if (ok != null) {
      showError("Usuário Inválido", "Favor entre com um nome de usuário válido",
          context);
      return false;
    }
    ok = validatePassword();
    if (ok != null) {
      showError("Senha Inválida", "Favor entre com uma senha válida", context);
      return false;
    }
    return true;
  }

  Future<int> postLoginUser(BuildContext context) async {
    loading = true;
    bool firstLogin = false;
    bool noRegistration = false;
    final _save = FlutterSecureStorage();
    //* GRR To Lower Case
    login.user = login.user.toLowerCase();

    AccountCredentials l = new AccountCredentials(
      username: login.user,
      password: login.password,
    );
    int loginStatusCode;
    String loginJson = json.encode(l.toJson());

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final _uri = buildUri("/login");

    int s;
    try {
      s = await http
          .post(_uri, body: loginJson, headers: mapHeaders)
          .then((http.Response response) async {
        final int statusCode = response.statusCode;
        //print("BodyLogin >>> $loginJson");
        //print("Headers >>> $mapHeaders");
        //print("-------------------------------------------------------");
        //print("Request on: $_url/login");
        //print("Status Code: ${response.statusCode}");
        //print("Posting User Login...");
        s = statusCode;

        if ((statusCode == 200) || (statusCode == 201)) {
          var j = json.decode(response.body);
          //First login?
          if (noRegistration == j["registered"]) {
            firstLogin = true;
          } else {
            firstLogin = false;
          }

          //Token firebase
          //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
          //_firebaseMessaging.subscribeToTopic('all');
          //String firebaseToken = await _firebaseMessaging.getToken();
          //setFirebaseToken(j["token"], firebaseToken, j["userId"], context);

          //User Credentials
          //_save.write(key: "firebaseToken", value: firebaseToken);

          if (!firstLogin) {
            _save.write(key: "token", value: j["token"]);
            _save.write(key: "user", value: login.user);
            _save.write(key: "userId", value: j["userId"]);
          }

          return statusCode;
        } else {
          return statusCode;
        }
      });
    } catch (on, stackTrace) {
      print(stackTrace);
      showError("Erro desconhecido", "Erro: $on", context);
    }

    if (firstLogin) {
      loading = false;
      return 0;
    }

    final token = await _save.read(key: "token");
    final userId = await _save.read(key: "userId");

    Map<String, String> mapHeadersToken = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    print("Buscando usuário! S = $s");
    final _uriGet = buildUri("/users/$userId");
    if (s == 200 || s == 201) {
      try {
        //Get user:
        //ignore: unused_local_variable
        bool ok = await http.get(_uriGet, headers: mapHeadersToken)
        // ignore: missing_return
            .then((http.Response response) {
          final int statusCode = response.statusCode;

          //print("-------------------------------------------------------");
          //print("Request on: $_url/users/$userId");
          //print("Status Code: ${response.statusCode}");
          //print("Loading User Profile...");
          //print("-------------------------------------------------------");

          if ((statusCode == 200) || (statusCode == 201)) {
            User user = User.fromJson(jsonDecode(response.body));
            _save.write(key: "name", value: user.name);
            _save.write(key: "email", value: user.email);
            _save.write(key: "lastName", value: user.lastName);
            _save.write(key: "isAdmin", value: user.adm.toString());
            loginStatusCode = 200;
          } else {
            loginStatusCode = 400;
            showError("Erro desconhecido", "Erro: $statusCode", context);
          }
        });
      } catch (e) {
        loginStatusCode = 400;
        showError("Erro desconhecido", "Erro: $e", context);
      }
    } else {
      loginStatusCode = s;
    }
    loading = false;
    return loginStatusCode;
  }
}