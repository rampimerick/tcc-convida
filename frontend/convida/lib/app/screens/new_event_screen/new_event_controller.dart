
import 'dart:io';
import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:convida/app/shared/models/mobx/new_event.dart';
import 'package:convida/app/shared/models/occurrence.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'package:convida/app/shared/util/dialogs_widget.dart';
import 'package:convida/app/shared/validations/event_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:convida/app/shared/global/constants.dart';
part 'new_event_controller.g.dart';

class NewEventController = _NewEventControllerBase with _$NewEventController;

abstract class _NewEventControllerBase with Store {
  @observable
  bool loading = false;

  @observable
  var newEvent = NewEvent();
  String _url = kURL;

  @observable
  List <Occurrence> occurrences = [];

  @observable
  String occurrenceOneStart = "";

  @observable
  String occurrenceOneEnd = "";

  @observable
  String occurrenceTwoStart = "";

  @observable
  String occurrenceTwoEnd = "";

  @observable
  String occurrenceThreeStart = "";

  @observable
  String occurrenceThreeEnd = "";

  @observable
  String occurrenceFourStart = "";

  @observable
  String occurrenceFourEnd = "";

  @computed
  bool get isValid {
    return ((validateName() == null) &&
        (validateTarget() == null) &&
        (validateDesc() == null) &&
        (validateAddress() == null) &&
        (validateComplement() == null) &&
        (validateLink() == null));
  }

  @action
  String setNewType() {
    return newEvent.type;
  }

  String validateName() {
    return nameValidation(newEvent.name);
  }

  String validateTarget() {
    return targetValidation(newEvent.target);
  }

  String validateDesc() {
    return descriptionValidation(newEvent.desc);
  }

  String validateAddress() {
    return addressValidation(newEvent.address);
  }

  String validateComplement() {
    return complementValidation(newEvent.complement);
  }

  String validateLink() {
    return linkValidation(newEvent.link);
  }

  String validadeDateStart() {
    return dateValidation(newEvent.dateStart, "de início do evento");
  }

  String validadeDateEnd() {
    return dateValidation(newEvent.dateEnd, "de fim do evento");
  }

  String validadeHourStart() {
    return hourValidation(newEvent.hrStart, 'início do evento');
  }

  String validadeHourEnd() {
    return hourValidation(newEvent.hrEnd, 'fim do evento');
  }

  String validadeSubStart() {
    return dateValidation(newEvent.subStart, "de início das inscrições");
  }

  String validadeSubEnd() {
    return dateValidation(newEvent.subEnd, "de fim das inscrições");
  }

  String validadeRecurrentStart(value) {
    return dateValidationOccurrences(value, "do início do evento");
  }

  String validadeRecurrentEnd(value) {
    return dateValidationOccurrences(value, "de fim do evento");
  }

  String datesValidations(bool isSwitchedSubs) {
    //*Tratar todas as datas:

    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateFormat hourFormat = new DateFormat("HH:mm");

    DateTime parsedHrStart = hourFormat.parse(newEvent.hrStart);
    DateTime parsedHrEnd = hourFormat.parse(newEvent.hrEnd);

    DateTime parsedDateStart = dateFormat.parse(newEvent.dateStart);
    DateTime parsedDateEnd = dateFormat.parse(newEvent.dateEnd);

    DateTime parsedDateStartOccurrence;
    DateTime parsedDateEndOccurrence;

    DateTime parsedSubEnd;

    DateTime parsedSubStart;
    if (isSwitchedSubs) {
      parsedSubStart = dateFormat.parse(newEvent.subStart);
      parsedSubEnd = dateFormat.parse(newEvent.subEnd);
    }

    //Check if Date Start > Date End
    if (parsedDateStart.compareTo(parsedDateEnd) > 0) {
      return "A Data de Fim do evento está antes da Data de Início!";
    }


    for(int i = 0; i < occurrences.length; i++){
      print("${occurrences[i].start} e ${occurrences[i].end}");

      if(occurrences[i].start == "" && occurrences[i].end != ""){
        return "Como a Data de Fim da recorrência foi informada, informe a Data de Início!";
      }
      if(occurrences[i].start != "" && occurrences[i].end == ""){
        return "Como a Data de Início da recorrência foi informada, informe a Data de Fim!";
      }

        parsedDateStartOccurrence = dateFormat.parse(occurrences[i].start);
        parsedDateEndOccurrence = dateFormat.parse(occurrences[i].end);


        if (parsedDateStartOccurrence.compareTo(parsedDateEndOccurrence) > 0) {
          return "A Data de Fim da recorrência do evento está antes da Data de Início!";
        }
    }


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

  Future<int> postNewEvent(String type, bool isSwitchedSubs, LatLng coords, bool isOnline, BuildContext context) async {
    loading = true;
    final _save = FlutterSecureStorage();
    String _token = await _save.read(key: "token");
    final String userId = await _save.read(key: "userId");

    var mapHeaders = getHeaderToken(_token);

    //!GET USER
    //User user;
    /* try {
      user = await http
          .get("$_url/users/$userId", headers: mapHeaders)
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if ((statusCode == 200) || (statusCode == 201)) {
          return User.fromJson(jsonDecode(response.body));
        } else {
          showError("Erro no servidor", "Erro: $statusCode", context);
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
    } */

    if (isSwitchedSubs == false) {
      newEvent.setSubStart("");
      newEvent.setSubEnd("");
    }

    //*Tratar todas as datas:
    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateFormat hourFormat = new DateFormat("HH:mm");
    DateFormat postFormat = new DateFormat("yyyy-MM-ddTHH:mm:ss");

    DateTime parsedDateStart = dateFormat.parse(newEvent.dateStart);
    DateTime parsedDateEnd = dateFormat.parse(newEvent.dateEnd);
    DateTime parsedHrStart = hourFormat.parse(newEvent.hrStart);
    DateTime parsedHrEnd = hourFormat.parse(newEvent.hrEnd);

    String postDateStart = postFormat.format(parsedDateStart);
    String postDateEnd = postFormat.format(parsedDateEnd);
    String postHrStart = postFormat.format(parsedHrStart);
    String postHrEnd = postFormat.format(parsedHrEnd);

    String postSubStart = "";
    String postSubEnd = "";


    if (isSwitchedSubs) {
      DateTime parsedSubStart = dateFormat.parse(newEvent.subStart);
      DateTime parsedSubEnd = dateFormat.parse(newEvent.subEnd);
      postSubStart = postFormat.format(parsedSubStart);
      postSubEnd = postFormat.format(parsedSubEnd);
    }

    Event p = new Event(
        name: newEvent.name,
        target: newEvent.target,
        desc: newEvent.desc,
        address: newEvent.address,
        complement: newEvent.complement,
        hrStart: postHrStart,
        hrEnd: postHrEnd,
        dateStart: postDateStart,
        dateEnd: postDateEnd,
        link: newEvent.link,
        type: type,
        startSub: postSubStart,
        endSub: postSubEnd,
        author: userId,
        lat: coords.latitude,
        lng: coords.longitude,
        active: true,
        online: isOnline,
        reported: false);

    String eventJson = json.encode(p.toJson());
    int code;

    //!POST EVENT
    try {
      code = await http.post(Uri.parse("$_url/events"), body: eventJson, headers: mapHeaders).then((http.Response response) {
        final int statusCode = response.statusCode;
        if ((statusCode == 200) || (statusCode == 201)) {
          print("evento criado");
          return statusCode;
        } else {
          print("Post Event Error: $statusCode");
          return statusCode;
        }
      });
    } catch (e) {
      showError("Erro desconhecido", "Erro: $e", context);
      return 500;
    }
    loading = false;
    return code;
  }

  Future<int> postRecurrent(String type, bool isSwitchedSubs, LatLng coords, bool isOnline, BuildContext context) async{
    dynamic response;
    final _save = FlutterSecureStorage();
    final _token = await _save.read(key: "token");
    final String userId = await _save.read(key: "userId");
    final String request = "$_url/events/recurrent";


    Map<String, String> mapHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0NjQ4MzYxNTgwOSIsImV4cCI6MTgwNDM3MDc5NSwiaWF0IjoxNjQ2NjkwNzk1fQ.11jdZd9UodZ6V4BGT2GGMjTD35yY0BmJcVc-N5Pk4_A33ENuehBoNnV5ewDeUzuluPFb7uY6BEz-gSfgCM-Rcw"
      HttpHeaders.authorizationHeader: "Bearer $_token"
    };

    if (isSwitchedSubs == false) {
      newEvent.setSubStart("");
      newEvent.setSubEnd("");
    }

    //*Tratar todas as datas:
    DateFormat dateFormat = new DateFormat("dd/MM/yyyy");
    DateFormat hourFormat = new DateFormat("HH:mm");
    DateFormat postFormat = new DateFormat("yyyy-MM-ddTHH:mm:ss");

    DateTime parsedDateStart = dateFormat.parse(newEvent.dateStart);
    DateTime parsedDateEnd = dateFormat.parse(newEvent.dateEnd);
    DateTime parsedHrStart = hourFormat.parse(newEvent.hrStart);
    DateTime parsedHrEnd = hourFormat.parse(newEvent.hrEnd);
    List <DateTime> parsedDateStartOccurrence  = [];
    List <DateTime> parsedDateEndOccurrence  = [];

    String postDateStart = postFormat.format(parsedDateStart);
    String postDateEnd = postFormat.format(parsedDateEnd);
    String postHrStart = postFormat.format(parsedHrStart);
    String postHrEnd = postFormat.format(parsedHrEnd);
    List<String> postDateStartOccurrence = [];
    List<String> postDateEndOccurrence = [];

    String postSubStart = "";
    String postSubEnd = "";

    List <Occurrence> o = [];



    if (isSwitchedSubs) {
      DateTime parsedSubStart = dateFormat.parse(newEvent.subStart);
      DateTime parsedSubEnd = dateFormat.parse(newEvent.subEnd);
      postSubStart = postFormat.format(parsedSubStart);
      postSubEnd = postFormat.format(parsedSubEnd);
    }

    Event p = new Event(
        name: newEvent.name,
        target: newEvent.target,
        desc: newEvent.desc,
        address: newEvent.address,
        complement: newEvent.complement,
        hrStart: postHrStart,
        hrEnd: postHrEnd,
        dateStart: postDateStart,
        dateEnd: postDateEnd,
        link: newEvent.link,
        type: type,
        startSub: postSubStart,
        endSub: postSubEnd,
        author: userId,
        lat: coords.latitude,
        lng: coords.longitude,
        active: true,
        online: isOnline,
        reported: false
    );

    //convert to date
    for(int i = 0; i < occurrences.length; i++){
      parsedDateStartOccurrence .add(dateFormat.parse(occurrences[i].start));
      parsedDateEndOccurrence .add(dateFormat.parse(occurrences[i].end));
    }

    //convert to string
    for(int i = 0; i < parsedDateStartOccurrence .length && i < parsedDateEndOccurrence .length; i++){
      postDateStartOccurrence .add(postFormat.format(parsedDateStartOccurrence [i]));
      postDateEndOccurrence .add(postFormat.format(parsedDateEndOccurrence [i]));
    }

    //Insert occurrences at list<Occurrence>
    for(int i = 0; i < postDateStartOccurrence.length && i < postDateEndOccurrence.length; i++){
      o.add(Occurrence(start: postDateStartOccurrence[i], end: postDateEndOccurrence[i]));
    }

    //Convert to Json
    var body = jsonEncode({
      "event": p.toJson(),
      "occurrences": o.map((i) => i.toJson()).toList()
    });

   // print(body);

    try {
      response = await http.post(Uri.parse(request), body: body, headers: mapHeaders);
      final int statusCode = response.statusCode;
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        return statusCode;
      } else if (response.statusCode == 401) {
        occurrences.clear();
        return statusCode;
      } else if (response.statusCode == 404) {
        occurrences.clear();
        return statusCode;
      } else if (response.statusCode == 500) {
        occurrences.clear();
        return statusCode;
      } else {
        occurrences.clear();
        showError("Erro Desconhecido", "StatusCode: ${response.statusCode}", context);
      }
    } catch (e) {
      occurrences.clear();
      showError("Erro desconhecido", "Erro: $e", context);
      return 500;
    }
    loading = false;
    return response;
  }

  bool checkAll(BuildContext context, bool isSwitchedSubs) {
    String error;

    error = nameValidation(newEvent.name);
    if (error != null) {
      showError("Nome inválido", error, context);
      return false;
    }

    error = targetValidation(newEvent.target);
    if (error != null) {
      showError("Público Alvo inválido", error, context);
      return false;
    }

    error = descriptionValidation(newEvent.desc);
    if (error != null) {
      showError("Descrição inválida", error, context);
      return false;
    }

    error = addressValidation(newEvent.address);
    if (error != null) {
      showError("Endereço inválido", error, context);
      return false;
    }

    error = complementValidation(newEvent.complement);
    if (error != null) {
      showError("Complemento inválido", error, context);
      return false;
    }

    error = linkValidation(newEvent.link);
    if (error != null) {
      showError("Link ou Email inválido", error, context);
      return false;
    }

    error = hourValidation(newEvent.hrStart, "início do evento");
    if (error != null) {
      showError("Horário inválido", error, context);
      return false;
    }

    error = hourValidation(newEvent.hrEnd, "fim do evento");
    if (error != null) {
      showError("Horário inválido", error, context);
      return false;
    }

    error = dateValidation(newEvent.dateStart, "de início do evento");
    if (error != null) {
      showError("Data inválida", error, context);
      return false;
    }

    error = dateValidation(newEvent.dateEnd, "de fim do evento");
    if (error != null) {
      showError("Data inválida", error, context);
      return false;
    }

    for(int i = 0; i < occurrences.length; i++) {
      error = dateValidation(occurrences[i].start, "de início da recorrência do evento");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }
    }

    for(int i = 0; i < occurrences.length; i++) {
      error = dateValidation(occurrences[i].end, "de fim da recorrência do evento");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }
    }


    if (isSwitchedSubs) {
      error = dateValidation(newEvent.subStart, "de início das inscrições");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }

      error = dateValidation(newEvent.subEnd, "de fim das inscrições");
      if (error != null) {
        showError("Data inválida", error, context);
        return false;
      }
    }

    return true;
  }
}
