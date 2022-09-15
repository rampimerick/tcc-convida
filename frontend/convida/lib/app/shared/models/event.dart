import 'package:flutter/material.dart';

class Event {
  //Json Variables
  String id;
  String name;
  String target;
  String address;
  String complement;
  String hrStart;
  String hrEnd;
  String dateStart;
  String dateEnd;
  String desc;
  String startSub;
  String endSub;
  String link;
  String type;
  String author;
  //String recurrent;
  double lat;
  double lng;
  bool active;
  bool online;
  bool reported;
  int nbmrFavorites;
  int nbmrConfirmed;

  //Aux Variables:
  String image;
  String typeImage;
  String typeIcon;
  Color typeColor;
  String dateString;

  Event(
      {
        this.id,
        this.name,
        this.target,
        this.address,
        this.complement,
        this.hrStart,
        this.hrEnd,
        this.dateStart,
        this.dateEnd,
        this.desc,
        this.startSub,
        this.endSub,
        this.link,
        this.type,
        this.author,
        //this.recurrent,
        this.lat,
        this.lng,
        this.active,
        this.online,
        this.reported,
        this.nbmrFavorites,
        this.nbmrConfirmed
      });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    target = json['target'];
    address = json['address'];
    complement = json['complement'];
    hrStart = json['hrStart'];
    hrEnd = json['hrEnd'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    desc = json['desc'];
    startSub = json['startSub'];
    endSub = json['endSub'];
    link = json['link'];
    type = json['type'];
    author = json['author'];
    //recurrent = json['recurrent'];
    lat = json['lat'];
    lng = json['lng'];
    active = json['active'];
    online = json['online'];
    reported = json['reported'];
    nbmrFavorites = json['nbmrFavorites'];
    nbmrConfirmed = json['nbmrConfirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['target'] = this.target;
    data['address'] = this.address;
    data['complement'] = this.complement;
    data['hrStart'] = this.hrStart;
    data['hrEnd'] = this.hrEnd;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['desc'] = this.desc;
    data['startSub'] = this.startSub;
    data['endSub'] = this.endSub;
    data['link'] = this.link;
    data['type'] = this.type;
    data['author'] = this.author;
    //data['recurrent'] = this.recurrent;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['active'] = this.active;
    data['online'] = this.online;
    data['reported'] = this.reported;
    data['nbmrFavorites'] = this.nbmrFavorites;
    data['nbmrConfirmed'] = this.nbmrConfirmed;
    return data;
  }
}
