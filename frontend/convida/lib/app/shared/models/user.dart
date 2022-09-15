import 'package:convida/app/shared/models/event.dart';

class User {
  String id;
  String login;
  String name;
  String lastName;
  String password;
  String email;
  String birth;
  bool adm;
  List<Event> fav;

  User(
      {this.name,
      this.lastName,
      this.id,
      this.login,
      this.email,
      this.password,
      this.birth,
      this.adm,
      this.fav});

  //! Start to use this constructor:
  User.fromJsonWithoutFavorites(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    lastName = json['lastName'];
    login = json['login'];
    email = json['email'];
    birth = json['birth'];
    adm = json['adm'];
    password = json['password'];
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    lastName = json['lastName'];
    login = json['login'];
    email = json['email'];
    birth = json['birth'];
    adm = json['adm'];
    password = json['password'];
    try {
      fav = new List<Event>();
      json['fav'].forEach((v) {
        fav.add(new Event.fromJson(v));
      });
    } catch (e) {
      //print("User without favorites events!");
      fav = [];
    }
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['login'] = this.login;
    data['email'] = this.email;
    data['birth'] = this.birth;
    data['adm'] = this.adm;
    data['password'] = this.password;
    if (this.fav != null) {
      data['fav'] = this.fav.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
