
class AccountCredentials {
  String username;
  String password;


  AccountCredentials({this.username, this.password});

  AccountCredentials.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
//    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
