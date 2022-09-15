import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/models/mobx/new_event.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'dart:io';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/event_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/global/constants.dart';
part 'alter_event_controller.g.dart';

class AlterEventController = _AlterEventControllerBase
    with _$AlterEventController;

abstract class _AlterEventControllerBase with Store {
  @observable
  bool loading = false;

  NewEvent alterEvent = NewEvent();
  String _url = kURL;

  String validateName() {
    return nameValidation(alterEvent.name);
  }

  String validateTarget() {
    return targetValidation(alterEvent.target);
  }

  String validateDesc() {
    return descriptionValidation(alterEvent.desc);
  }

  String validateAddress() {
    return addressValidation(alterEvent.address);
  }

  String validateComplement() {
    return complementValidation(alterEvent.complement);
  }

  String validateLink() {
    return linkValidation(alterEvent.link);
  }

  String validadeDateStart() {
    return dateValidation(alterEvent.dateStart, "de início do evento");
  }

  String validadeDateEnd() {
    return dateValidation(alterEvent.dateEnd, "de fim do evento");
  }

  String validadeHourStart() {
    return hourValidation(alterEvent.hrStart, 'início do evento');
  }

  String validadeHourEnd() {
    return hourValidation(alterEvent.hrEnd, 'fim do evento');
  }

  String validadeSubStart() {
    return dateValidation(alterEvent.subStart, "de início das inscrições");
  }

  String validadeSubEnd() {
    return dateValidation(alterEvent.subEnd, "de fim das inscrições");
  }

  String datesValidations(bool isSwitchedSubs) {
    //*Tratar todas as datas:

    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateFormat hourFormat = new DateFormat("HH:mm");

    DateTime parsedHrStart = hourFormat.parse(alterEvent.hrStart);
    DateTime parsedHrEnd = hourFormat.parse(alterEvent.hrEnd);

    DateTime parsedDateStart = dateFormat.parse(alterEvent.dateStart);
    DateTime parsedDateEnd = dateFormat.parse(alterEvent.dateEnd);

    DateTime parsedSubEnd;
    DateTime parsedSubStart;
    if (isSwitchedSubs) {
      parsedSubStart = dateFormat.parse(alterEvent.subStart);
      parsedSubEnd = dateFormat.parse(alterEvent.subEnd);
    }

    //Check if Date Start > Date End
    if (parsedDateStart.compareTo(parsedDateEnd) > 0) {
      return "A Data de Fim do evento está antes da Data de Início!";
    }
    //Check if Date Start == Date End, Check Hours
    else if (parsedDateStart.day == parsedDateEnd.day) {
      if (parsedHrStart.compareTo(parsedHrEnd) > 0) {
        return "Evento no mesmo dia, as horas estão incorretas!";
      }
      return "";
    } else if (isSwitchedSubs) {
      //Check if Date Sub End > Sub start
      if (parsedSubStart.compareTo(parsedSubEnd) > 0) {
        return "O Fim das inscrições está antes do Início!";
      }
      //?Talvez não seja boa essa validação, comparar com o fim?
      //Check if Date End > Date Sub End

      if (parsedSubEnd.compareTo(parsedDateEnd) > 0) {
        return "As inscrições não encerram junto com o Evento!";
      }

      return "";
    } else {
      return "";
    }
  }

  Future<int> putEvent(String type, bool isSwitchedSubs, Event event,
      BuildContext context) async {
    loading = true;
    final _save = FlutterSecureStorage();
    final _token = await _save.read(key: "token");

    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $_token"
    };

    if (isSwitchedSubs == false) {
      alterEvent.setSubStart("");
      alterEvent.setSubEnd("");
    }

    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateFormat hourFormat = new DateFormat("HH:mm");
    DateFormat postFormat = new DateFormat("yyyy-MM-ddTHH:mm:ss");

    DateTime parsedDateStart = dateFormat.parse(alterEvent.dateStart);
    DateTime parsedDateEnd = dateFormat.parse(alterEvent.dateEnd);
    DateTime parsedHrStart = hourFormat.parse(alterEvent.hrStart);
    DateTime parsedHrEnd = hourFormat.parse(alterEvent.hrEnd);

    String postDateStart = postFormat.format(parsedDateStart);
    String postDateEnd = postFormat.format(parsedDateEnd);
    String postHrStart = postFormat.format(parsedHrStart);
    String postHrEnd = postFormat.format(parsedHrEnd);

    String postSubStart = "";
    String postSubEnd = "";

    if (isSwitchedSubs) {
      DateTime parsedSubStart = dateFormat.parse(alterEvent.subStart);
      DateTime parsedSubEnd = dateFormat.parse(alterEvent.subEnd);
      postSubStart = postFormat.format(parsedSubStart);
      postSubEnd = postFormat.format(parsedSubEnd);
    }

    Event p = new Event(
        id: event.id,
        name: alterEvent.name,
        target: alterEvent.target,
        desc: alterEvent.desc,
        hrStart: postHrStart,
        hrEnd: postHrEnd,
        dateStart: postDateStart,
        dateEnd: postDateEnd,
        link: alterEvent.link,
        type: type,
        address: alterEvent.address,
        complement: alterEvent.complement,
        startSub: postSubStart,
        endSub: postSubEnd,
        author: event.author,
        lat: event.lat,
        lng: event.lng,
        active: true,
        online: alterEvent.online);

    String eventJson = json.encode(p.toJson());
    //print(eventJson);

    int code;
    try {
      code = await http
          .put(Uri.parse("$_url/events/${event.id}"), body: eventJson, headers: mapHeaders)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if ((statusCode == 200) || (statusCode == 201)) {
          //print("Put Event Success!");
          return statusCode;
        } else {
          //print("Put Event Error: $statusCode");
          return statusCode;
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
    }

    loading = false;
    return code;
  }

  bool checkAll(BuildContext context, bool isSwitchedSubs) {
    String error;

    error = nameValidation(alterEvent.name);
    if (error != null) {
      showError("Nome inválido", error, context);
      return false;
    }

    error = targetValidation(alterEvent.target);
    if (error != null) {
      showError("Público Alvo inválido", error, context);
      return false;
    }

    error = descriptionValidation(alterEvent.desc);
    if (error != null) {
      showError("Descrição inválida", error, context);
      return false;
    }

    error = addressValidation(alterEvent.address);
    if (error != null) {
      showError("Endereço inválido", error, context);
      return false;
    }

    error = complementValidation(alterEvent.complement);
    if (error != null) {
      showError("Complemento inválido", error, context);
      return false;
    }

    error = linkValidation(alterEvent.link);
    if (error != null) {
      showError("Link ou Email inválido", error, context);
      return false;
    }

    error = hourValidation(alterEvent.hrStart, "início do evento");
    if (error != null) {
      showError("Horário inválido", error, context);
      return false;
    }

    error = hourValidation(alterEvent.hrEnd, "fim do evento");
    if (error != null) {
      showError("Horário inválido", error, context);
      return false;
    }

    error = dateValidation(alterEvent.dateStart, "de início do evento");
    if (error != null) {
      showError("Data inválida", error, context);
      return false;
    }

    error = dateValidation(alterEvent.dateEnd, "de fim do evento");
    if (error != null) {
      showError("Data inválida", error, context);
      return false;
    }

    if (isSwitchedSubs) {
      error = dateValidation(alterEvent.subStart, "de início das inscrições");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }

      error = dateValidation(alterEvent.subEnd, "de fim das inscrições");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }
    }

    return true;
  }
}
