

class Occurrence {
  String start;
  String end;

  Occurrence(
      {
        this.start,
        this.end
      });

  Occurrence.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
