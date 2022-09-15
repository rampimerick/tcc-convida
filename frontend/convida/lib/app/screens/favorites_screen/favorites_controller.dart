import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/helpers/event_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/util/dialogs_widget.dart';

String _url = kURL;

Future<List> getAllFavoriteEvents(
    BuildContext context, String token, String userId) async {
  dynamic response;
  final String request = "$_url/users/fav/$userId";

  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get Favorite Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
    } else {
      errorStatusCode(
          response.statusCode, context, "Erro ao carregar eventos favoritados");
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}