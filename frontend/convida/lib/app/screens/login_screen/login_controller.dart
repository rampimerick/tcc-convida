import 'package:convida/app/shared/DAO/firebase_requisitions.dart';
import 'package:convida/app/shared/models/login.dart';
import 'package:convida/app/shared/models/mobx/login.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/push_nofitications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/login_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/global/constants.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  Login login = new Login();
  Login recovery = new Login();
  String _url = kURL;

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

    int s;
    try {
      s = await http
          .post(Uri.parse("$_url/login"), body: loginJson, headers: mapHeaders)
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

          //Token firebase
          //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
          //_firebaseMessaging.subscribeToTopic('all');
          //String firebaseToken = await _firebaseMessaging.getToken();
          //setFirebaseToken(j["token"], firebaseToken, j["userId"], context);

          //User Credentials
          //_save.write(key: "firebaseToken", value: firebaseToken);
          _save.write(key: "token", value: j["token"]);
          _save.write(key: "user", value: login.user);
          _save.write(key: "userId", value: j["userId"]);

          return statusCode;
        } else {
          //print("Error Token");
          //print("-------------------------------------------------------");
          return statusCode;
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
    }

    final token = await _save.read(key: "token");
    final userId = await _save.read(key: "userId");

    //print("TOKEN: $token");
    //print("LOGIN: ${login.user}");
    //print("ID: $userId");

    Map<String, String> mapHeadersToken = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    //print("Buscando usuário! S = $s");
    if (s == 200 || s == 201) {
      try {
        //Get user:
        bool ok =
            await http.get(Uri.parse("$_url/users/$userId"), headers: mapHeadersToken)
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
            if (user.name == null) {
              ////print("---> Primeiro Login! <---");
              loginStatusCode = 0;
            } else {
              _save.write(key: "name", value: user.name);
              _save.write(key: "email", value: user.email);
              _save.write(key: "lastName", value: user.lastName);
              loginStatusCode = 200;
            }
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
