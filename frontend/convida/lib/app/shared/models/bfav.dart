class Bfav {
  String grr;
  String id;


  Bfav({this.grr, this.id});

  Bfav.fromJson(Map<String, dynamic> json) {
    grr = json['grr'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grr'] = this.grr;
    data['id'] = this.id;
    return data;
  }
}
