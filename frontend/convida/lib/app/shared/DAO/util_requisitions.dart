import 'dart:io';

import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';

void printRequisition(String request, int statusCode, String type) {
  //print("-------------------------------------------------------");
  //print("Type: $type");
  //print("Request on: $request");
  if (statusCode.toString().startsWith("2")) {
    //print("Status Code: $statusCode - Success");
  } else {
    //print("Status Code: $statusCode - Error");
  }
  //print("-------------------------------------------------------");
}

void errorStatusCode(int statusCode, BuildContext context, String error) {
  if (statusCode == 401) {
    showError("$error", "Favor tente novamente", context);
  } else if (statusCode == 404) {
    showError("Erro 404", "Evento ou usuário não foi encontrado", context);
  } else if (statusCode == 500) {
    showError("Erro 500", "Erro no servidor, favor tente novamente mais tarde",
        context);
  } else if (statusCode == 405) {
    showError(
        "Infelizmente não foi possível logar",
        "Sua senha ou seu email @ufpr estão incorretos, ou o servidor da UFPR está fora do ar.",
        context);
    // showError(
    // "Erro servidor UFPR - LDAP",
    // "Infelizmente o servidor da UFPR está fora do ar, favor tente novamente mais tarde",
    // context);
  } else if (statusCode == 502) {
    showError(
        "Servidor UFPRConVIDA desligado ",
        "Infelizmente o servidor do app ConVIDA está fora do ar, favor tente novamente mais tarde",
        context);
  } else {
    showError("Erro Desconhecido", "StatusCode: $statusCode", context);
  }
}

Map<String, String> getHeaderToken(String token) {
  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token"
  };
}

Map<String, String> getHeader() {
  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };
}
