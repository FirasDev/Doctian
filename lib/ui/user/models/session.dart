class SessionEvent {
  DateTime session;
  bool status;

  SessionEvent({
    this.session,
    this.status,
  });

  SessionEvent.fromJson(Map<String, dynamic> json) {
    //
    session = DateTime.parse(json['session']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session'] = this.session;
    data['status'] = this.status;
    return data;
  }
}
