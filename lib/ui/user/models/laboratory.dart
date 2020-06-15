import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/users.dart';

class Laboratory {
  String id;
  String name;
  String coverPicture;
  String licenceNumber;
  DateTime dispoHourStart;
  DateTime dispoHourEnd;
  String workDays;
  List<Analysis> analyses;
  User owner;
  Laboratory({
    this.id,
    this.name,
    this.coverPicture,
    this.licenceNumber,
    this.dispoHourStart,
    this.dispoHourEnd,
    this.workDays,
    this.analyses,
    this.owner
  });

  Laboratory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    coverPicture = json['coverPicture'];
    licenceNumber = json['licenceNumber'];
    dispoHourStart = DateTime.parse(json['dispoHourStart']);
    dispoHourEnd = DateTime.parse(json['dispoHourEnd']);
    workDays = json['workDays'];
    owner = User.ownerfromJson(json['owner']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['coverPicture'] = this.coverPicture;
    data['licenceNumber'] = this.licenceNumber;
    data['dispoHourStart'] = this.dispoHourStart;
    data['dispoHourEnd'] = this.dispoHourEnd;
    data['workDays'] = this.workDays;
    data['owner'] = this.owner;
    return data;
  }
}