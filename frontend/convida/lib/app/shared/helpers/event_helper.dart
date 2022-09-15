import 'dart:convert';
import 'package:convida/app/shared/global/constants.dart';
import 'package:convida/app/shared/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Event> parseEvents(String responseBody) {
  final parsedEvents = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<Event> events =
      parsedEvents.map<Event>((json) => Event.fromJson(json)).toList();

  //Set the aux variable:
  events.forEach((Event event) {
    event.typeIcon = setEventIcon(event.type);
    event.typeImage = setEventImage(event.type);
    event.typeColor = setEventColor(event.type);
    event.dateString = setEventDateString(event);
  });

  return events;
}

Event parseEvent(String responseBody) {
  dynamic parsedEvent = json.decode(responseBody);
  final Event event = Event.fromJson(parsedEvent);

  //Set the aux variable:
  event.typeIcon = setEventIcon(event.type);
  event.typeImage = setEventImage(event.type);
  event.typeColor = setEventColor(event.type);
  event.dateString = setEventDateString(event);

  return event;
}

String setEventDateString(Event event) {
  try {
    DateFormat dateFormat = new DateFormat("dd MMM yyyy", "pt_BR");
    DateFormat hourFormat = new DateFormat("hh'h'mm", "pt_BR");

    DateTime dateStart = DateTime.parse(event.dateStart);
    String date = dateFormat.format(dateStart);

    DateTime hourStart = DateTime.parse(event.hrStart);
    String hour = hourFormat.format(hourStart);

    return "$date - $hour";
  } catch (e) {
    //print(e.toString());
    return "Data incorreta";
  }
}

String setEventImage(String type) {
  switch (type) {
    case kHealthName:
      return kHealthImage;
      break;
    case kSportName:
      return kSportImage;
      break;
    case kPartyName:
      return kPartyImage;
      break;
    case kArtName:
      return kArtImage;
      break;
    case kFaithName:
      return kFaithImage;
      break;
    case kGraduationName:
      return kGraduationImage;
      break;
    case kOtherName:
      return kOtherImage;
      break;
    default:
      return kOtherImage;
      break;
  }
}

String setEventIcon(String type) {
  switch (type) {
    case kHealthName:
      return kHealthIcon;
      break;
    case kSportName:
      return kSportIcon;
      break;
    case kPartyName:
      return kPartyIcon;
      break;
    case kArtName:
      return kArtIcon;
      break;
    case kFaithName:
      return kFaithIcon;
      break;
    case kGraduationName:
      return kGraduationIcon;
      break;
    case kOtherName:
      return kOtherIcon;
      break;
    default:
      return kOtherIcon;
      break;
  }
}

Color setEventColor(String type) {
  switch (type) {
    case kHealthName:
      return kHealthColor;
      break;
    case kSportName:
      return kSportColor;
      break;
    case kPartyName:
      return kPartyColor;
      break;
    case kArtName:
      return kArtColor;
      break;
    case kFaithName:
      return kFaithColor;
      break;
    case kGraduationName:
      return kGraduationColor;
      break;
    case kOtherName:
      return kOtherColor;
      break;
    default:
      return kOtherColor;
      break;
  }
}
