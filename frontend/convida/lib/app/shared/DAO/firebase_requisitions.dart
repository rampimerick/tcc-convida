import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/models/device_token.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String _url = kURL;

Future<bool> setFirebaseToken(String token, String firebaseToken, String userId,
    BuildContext context) async {
  dynamic response;
  final String request = "$_url/users/setfirebasetoken";

  DeviceToken deviceToken =
      DeviceToken(userId: userId, firebaseToken: firebaseToken);
  String deviceJson = json.encode(deviceToken.toJson());
  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.post(Uri.parse(request), body: deviceJson, headers: mapHeaders);
    printRequisition(request, response.statusCode, "Set Device Token");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return true;
    } else {
      errorStatusCode(response.statusCode, context, "Erro ao criar Evento");
      return false;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return false;
  }
}

Future<bool> removeFirebaseToken(String token, String firebaseToken,
    String userId, BuildContext context) async {
  dynamic response;
  final String request = "$_url/users/removefirebasetoken";

  DeviceToken deviceToken =
      DeviceToken(userId: userId, firebaseToken: firebaseToken);
  String deviceJson = json.encode(deviceToken.toJson());
  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.post(Uri.parse(request), body: deviceJson, headers: mapHeaders);
    printRequisition(request, response.statusCode, "Remove Device Token");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return true;
    } else {
      errorStatusCode(response.statusCode, context, "Erro ao criar Evento");
      return false;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return false;
  }
}
