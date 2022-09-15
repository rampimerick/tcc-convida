class DeviceToken {
  String userId;
  String firebaseToken;

  DeviceToken({this.userId, this.firebaseToken});

  DeviceToken.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firebaseToken = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
