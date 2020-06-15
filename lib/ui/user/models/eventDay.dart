class EventDay {
  String id;
  int count;
  int status;

  EventDay({
    this.id,
    this.count,
    this.status,
  });

  EventDay.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}
