import 'package:convida/app/shared/models/user.dart';

class Report {
  String id;
  String report;
  String userId;
  String userName;
  String userLastName;
  bool ignored;
  bool active;

  Report({this.userId, this.userLastName, this.userName, this.report, this.ignored, this.active});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    report = json['report'];
    userId = json['userId'];
    userName = json['userName'];
    userLastName = json['userLastName'];
    ignored = json['ignored'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName']= this.userName;
    data['userLastName'] = this.userLastName;
    data['report'] = this.report;
    data['ignored'] = this.ignored;
    data['active'] = this.active;
    return data;
  }
}