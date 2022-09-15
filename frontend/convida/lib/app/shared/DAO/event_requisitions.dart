import 'package:convida/app/shared/DAO/util_requisitions.dart';
import 'package:convida/app/shared/helpers/event_helper.dart';
import 'package:flutter/material.dart';
import 'package:convida/app/shared/global/constants.dart';
import 'package:http/http.dart' as http;

import 'package:convida/app/shared/util/dialogs_widget.dart';

String _url = kURL;

//*Requisition to get Events with Type e Search
Future<List> getEvents(
    String search, String type, bool checked, BuildContext context) async {
  String parsedSearch = Uri.encodeFull(search);
  String parsedType = Uri.encodeFull(type);
  dynamic response;
  String request;
  if (checked)
    request =
        "$_url/events/nametypeonlinesearch?text=$parsedSearch&type=$parsedType";
  else
    request = "$_url/events/nametypesearch?text=$parsedSearch&type=$parsedType";

  try {
    response = await http.get(Uri.parse(request));
    printRequisition(request, response.statusCode, "Get Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
    } else {
      errorStatusCode(response.statusCode, context, "Erro ao carregar Eventos");
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}

Future<List> getEventsByPresence(BuildContext context) async {
  dynamic response;
  final String request = "$_url/events/confirmed";

  try {
    response = await http.get(Uri.parse(request));
    printRequisition(request, response.statusCode, "Get Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
    } else {
      errorStatusCode(response.statusCode, context, "Erro ao carregar Eventos");
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}

Future<List> getEventsSearchType(
    String search, Map filters, BuildContext context) async {
  String parsedHealthType = '%20';
  String parsedSportType = 'X';
  String parsedPartyType = 'X';
  String parsedArtType = 'X';
  String parsedFaithType = 'X';
  String parsedStudyType = 'X';
  String parsedOthersType = 'X';

  if (null != filters) {
    if (filters['healthType']) parsedHealthType = 'Sa%C3%BAde%20e%20Bem-estar';
    if (filters['sportType']) parsedSportType = 'Esporte%20e%20Lazer';
    if (filters['partyType'])
      parsedPartyType = 'Festas%20e%20Comemora%C3%A7%C3%B5es';
    if (filters['artType']) parsedArtType = 'Arte%20e%20Cultura';
    if (filters['faithType']) parsedFaithType = 'F%C3%A9%20e%20Espiritualidade';
    if (filters['studyType'])
      parsedStudyType = 'Acad%C3%AAmico%20e%20Profissional';
    if (filters['othersType']) parsedOthersType = 'Outros';

    if (!filters['healthType']) parsedHealthType = 'X';
    if (!filters['sportType']) parsedSportType = 'X';
    if (!filters['partyType']) parsedPartyType = 'X';
    if (!filters['artType']) parsedArtType = 'X';
    if (!filters['faithType']) parsedFaithType = 'X';
    if (!filters['studyType']) parsedStudyType = 'X';
    if (!filters['othersType']) parsedOthersType = 'X';

    //Tratar os erros quando todos sao null ou todos preenchidos. (Organization Screen)
    if ((filters['healthType']) &&
        (filters['sportType']) &&
        (filters['partyType']) &&
        (filters['artType']) &&
        (filters['faithType']) &&
        (filters['studyType']) &&
        (filters['othersType'])) {
      parsedHealthType = "%20";
    } else if ((!filters['healthType']) &&
        (!filters['sportType']) &&
        (!filters['partyType']) &&
        (!filters['artType']) &&
        (!filters['faithType']) &&
        (!filters['studyType']) &&
        (!filters['othersType'])) {
      parsedHealthType = "%20";
    }
  }
  String parsedSearch = Uri.encodeFull(search);
  String request;

  //!Arrumar as requisições:
  //"$_url/events/multtype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType&text7=$parsedOnlineType";

  if (filters['dataTypeWeek']) {
    request =
    "$_url/events/weektype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";
  } else if (filters['dataTypeDay']) {
    request =
    "$_url/events/todaytype?text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";
  } else
  request =
      "$_url/events/namemulttype?name=$parsedSearch&text=$parsedHealthType&text1=$parsedSportType&text2=$parsedPartyType&text3=$parsedArtType&text4=$parsedFaithType&text5=$parsedStudyType&text6=$parsedOthersType";

  dynamic response;

  try {
    response = await http.get(Uri.parse(request));
    printRequisition(request, response.statusCode, "Name Type Search Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
    } else {
      errorStatusCode(response.statusCode, context, "Erro ao carregar Eventos");
      return null;
    }
  } catch (e) {
    e.toString();
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}

Future<bool> getPresence(
    String userId, String eventId, String token, BuildContext context) async {
  var mapHeaders = getHeaderToken(token);
  final String request =
      "$_url/events/presence/?eventId=$eventId&userId=$userId";
  dynamic response;

  try {
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get Presence");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      final presence = response.body.toString().toLowerCase() == 'true';
      return presence;
    } else {
      errorStatusCode(
          response.statusCode, context, "Erro ao Confirmar Presença");
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}

void getConfirmPresence(
    String userId, String eventId, String token, BuildContext context) async {
  var mapHeaders = getHeaderToken(token);
  final String request =
      "$_url/events/confirmpresence/?eventId=$eventId&userId=$userId";
  dynamic response;

  try {
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get Confirm Presence");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
    } else {
      errorStatusCode(
          response.statusCode, context, "Erro ao Confirmar Presença");
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
  }
}

void getRemovePresence(
    String userId, String eventId, String token, BuildContext context) async {
  var mapHeaders = getHeaderToken(token);
  final String request =
      "$_url/events/removepresence/?eventId=$eventId&userId=$userId";
  dynamic response;

  try {
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get Remove Presence");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
    } else {
      errorStatusCode(
          response.statusCode, context, "Erro ao Confirmar Presença");
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
  }
}

//*Requisition to post a New Event
Future<bool> postNewEvent(
    String newEvent, String token, BuildContext context) async {
  dynamic response;
  final String request = "$_url/events";
  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.post(Uri.parse(request), body: newEvent, headers: mapHeaders);
    printRequisition(request, response.statusCode, "Post New Event");

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

Future<bool> putEvent(
    String event, String token, String eventId, BuildContext context) async {
  dynamic response;
  final String request = "$_url/events/$eventId";

  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.put(Uri.parse(request), body: event, headers: mapHeaders);
    printRequisition(request, response.statusCode, "Put Event");

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

// Future<List> getAllFavoriteEvents(
//     BuildContext context, String token, String userId) async {
//   dynamic response;
//   final String request = "$_url/users/fav/$userId";
//
//   try {
//     var mapHeaders = getHeaderToken(token);
//     response = await http.get(Uri.parse(request), headers: mapHeaders);
//     printRequisition(request, response.statusCode, "Get Favorite Events");
//
//     if ((response.statusCode == 200) || (response.statusCode == 201)) {
//       return parseEvents(response.body);
//     } else {
//       errorStatusCode(
//           response.statusCode, context, "Erro ao carregar eventos favoritados");
//       return null;
//     }
//   } catch (e) {
//     showError("Erro desconhecido", "Erro: $e", context);
//     return null;
//   }
// }

Future<List> getAllMyEvents(
    BuildContext context, String token, String userId) async {
  final String request = "$_url/users/myevents?text=$userId";
  //print(userId);
  dynamic response;

  try {
    var mapHeaders = getHeaderToken(token);
    response = await http.get(Uri.parse(request), headers: mapHeaders);
    printRequisition(request, response.statusCode, "Get My Events");

    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      return parseEvents(response.body);
    } else {
      errorStatusCode(
          response.statusCode, context, "Erro ao carregar seus eventos");
      return null;
    }
  } catch (e) {
    showError("Erro desconhecido", "Erro: $e", context);
    return null;
  }
}


// Future<List> getAllConfirmedEvents(
//     BuildContext context, String token, String userId) async {
//   dynamic response;
//   final String request = "$_url/users/confimed/$userId";
//
//   try {
//     var mapHeaders = getHeaderToken(token);
//     response = await http.get(Uri.parse(request), headers: mapHeaders);
//     printRequisition(request, response.statusCode, "Get Favorite Events");
//
//     if ((response.statusCode == 200) || (response.statusCode == 201)) {
//       return parseEvents(response.body);
//     } else {
//       errorStatusCode(response.statusCode, context, "Erro ao carregar eventos favoritados");
//       return null;
//     }
//   } catch (e) {
//     showError("Erro desconhecido", "Erro: $e", context);
//     return null;
//   }
// }

