import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/helpers/event_helper.dart';
import 'package:convida/app/shared/helpers/users_helper.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

String _url = kURL;

Future<User> getAuthor(String a, context) async {
  int statusCodeUser;

  Map<String, String> mapHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  User author;
  try {
    author = await http
        .get(Uri.parse("$_url/users/$a"), headers: mapHeaders)
        .then((http.Response response) {
      statusCodeUser = response.statusCode;
      if (statusCodeUser == 200 || statusCodeUser == 201) {
       // print("Author Sucess!");
        //User author = User.fromJson(jsonDecode(response.body));
        return parseUser(response.body);
      } else if (statusCodeUser == 401) {
        showError("Erro 401", "Não autorizado, favor logar novamente", context);
        return null;
      } else if (statusCodeUser == 404) {
        showError("Erro 404", "Autor não foi encontrado", context);
        return null;
      } else if (statusCodeUser == 500) {
        showError("Erro 500",
            "Erro no servidor, favor tente novamente mais tarde", context);
        return null;
      } else {
        showError("Erro Desconhecido", "StatusCode: $statusCodeUser", context);
        return null;
      }
    });
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }

  return author;
}

Future<Event> getMyEvent(eventId, context) async {
  var response;
  User eventAuthor;
  try {
    response = await http.get(Uri.parse("$_url/events/$eventId"));
    var jsonEvent;
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      jsonEvent = json.decode(response.body);
      Event e = Event.fromJson(jsonEvent);
      eventAuthor = await getAuthor(e.author, context);
      if (eventAuthor != null) {
        // print(eventAuthor.name);
        return parseEvent(response.body);
      } else {
        showError(
            "Erro ao carregar evento",
            "Infelizmente não foi possível carregar esse evento, tente novamente mais tarde",
            context);
        return e;
      }
    } else if (response.statusCode == 401) {
      showError("Erro 401", "Não autorizado, favor logar novamente", context);
      return null;
    } else if (response.statusCode == 404) {
      showError("Erro 404", "Autor não foi encontrado", context);
      return null;
    } else if (response.statusCode == 500) {
      // showError("Erro 500",
      //     "Erro no servidor, favor tente novamente mais tarde (AQUI)", context);
      return null;
    } else {
      showError(
          "Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
      return null;
    }
  } catch (e) {
    if (e.toString().contains("at character 1")) {
      return null;
    } else {
      showError("Erro desconhecido ao deletar!", "Erro: $e", context);
      return null;
    }
  }
}

Future<int> deleteMyEvent(String eventId, BuildContext context) async {
  final _save = FlutterSecureStorage();
  String _token = await _save.read(key: "token");

  Map<String, String> mapHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: "Bearer $_token"
  };
  var response;
  try {
    response = await http.delete(Uri.parse("$_url/events/$eventId"), headers: mapHeaders);
    int statusCode = response.statusCode;
    print("StatusCode DEL:$statusCode");

    if (statusCode == 200) {
      showSuccess("Evento removido com sucesso", "pop", context);
      return statusCode;
    } else if (statusCode == 401) {
      showError("Erro 401", "Não autorizado, favor logar novamente", context);
      return statusCode;
    } else if (statusCode == 404) {
      showError("Erro 404", "Evento ou usuário não foi encontrado", context);
      return statusCode;
    } else if (statusCode == 500) {
      showError("Erro 500", "Erro no servidor, favor tente novamente mais tarde (Delete)", context);
      return statusCode;
    } else {
      showError("Erro Desconhecido", "StatusCode: $statusCode", context);
      return statusCode;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return 500;
  }
}

