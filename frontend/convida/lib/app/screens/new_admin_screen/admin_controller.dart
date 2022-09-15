import 'dart:io';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/helpers/users_helper.dart';
import 'package:convida/app/shared/models/user.dart';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
part 'admin_controller.g.dart';

class NewAdminController = _NewAdminControllerBase with _$NewAdminController;

String _url = kURL;

abstract class _NewAdminControllerBase with Store {
  @observable
  ObservableList listItems = [].asObservable();

  @action
  Future<List> getUsersNameSearch(String search, BuildContext context) async {
    String parsedSearch = Uri.encodeFull(search);
    dynamic response;
    String request = "$_url/users/namesearch?text=$parsedSearch";

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
        var users = parseUsers(response.body);
        listItems.clear();
        if (listItems.isEmpty){
          try {
            for (var user in users) {
              User newAdmin = User(
                name: user.name,
                lastName: user.lastName,
                email: user.email,
                id: user.id,
                adm: user.adm,
              );
              listItems.add(newAdmin);
            }
            return parseUsers(response.body);
          } catch (e) {
            print("Erro!");
          }
        }
       // return parseUsers(response.body);
      } else if (response.statusCode == 401) {
        showError("Erro 401", "Não autorizado, favor logar novamente", context);
        return null;
      } else if (response.statusCode == 404) {
        showError("Erro 404", "Usuário não foi encontrado", context);
        return null;
      } else if (response.statusCode == 500) {
        showError("Erro 500",
            "Erro no servidor, favor tente novamente mais tarde", context);
        return null;
      } else {
        showError(
            "Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
        return null;
      }
    } catch (e) {
      e.toString();
      showError("Erro desconhecido ", "Erro: $e", context);
      return null;
    }
  }

  @action
  Future putAdmin(BuildContext context, String userId) async {
    dynamic response;
    final String request = "$_url/users/conadmzd87l3/$userId";

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
       // String search = "";
        listItems.removeWhere((item) => (item.id == userId));
        showSuccess("Adicionado com sucesso", "pop", context);
      } else if (response.statusCode == 401) {
        showError("Erro 401", "Não autorizado, favor logar novamente", context);
      } else if (response.statusCode == 404) {
        showError("Erro 404", "Usuário não foi encontrado", context);
      } else if (response.statusCode == 500) {
        showError("Erro 500", "Erro no servidor, favor tente novamente mais tarde", context);
      } else {
        showError("Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
      }
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
      return false;
    }
  }

}


