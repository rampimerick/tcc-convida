import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/helpers/event_helper.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String _url = kURL;

Future<List> getAllMyConfirmedEvents(
    BuildContext context, String token, String userId) async {
  dynamic response;
  final String request = "$_url/users/findMyConfirmedEvents/$userId";

  print(userId);
  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get Favorite Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
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

