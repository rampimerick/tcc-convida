import 'package:convida/app/shared/helpers/users_helper.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:convida/app/shared/global/constants.dart';


Future<List> getConfirmedUsers(BuildContext context, String eventId) async {

  String _url = kURL;
  final String request = "$_url/events/confirmedUsers/${eventId}";
  dynamic response;

  final _save = FlutterSecureStorage();
  final _token = await _save.read(key: "token");

  Map<String, String> mapHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: "Bearer $_token"
    };

  try {
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseUsers(response.body);
    } else if (response.statusCode == 401) {
      showError("Erro 401", "Não autorizado, favor logar novamente", context);
      return null;
    } else if (response.statusCode == 404) {
      showError("Erro 404", "Evento não foi encontrado", context);
      return null;
    } else if (response.statusCode == 500) {
      showError("Erro 500", "Erro no servidor, favor tente novamente mais tarde", context);
      return null;
    } else {
      showError("Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}
