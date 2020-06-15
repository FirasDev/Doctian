import 'package:hello_world/ui/user/models/users.dart';

class PharmaceuticalCompany {
  String id;
  String name;
  String coverPicture;
  String licenceNumber;
  DateTime dispoHourStart;
  DateTime dispoHourEnd;
  String workDays;
  User owner;
  PharmaceuticalCompany({
    this.id,
    this.name,
    this.coverPicture,
    this.licenceNumber,
    this.dispoHourStart,
    this.dispoHourEnd,
    this.workDays,
    this.owner
  });

  PharmaceuticalCompany.fromJson(Map<String, dynamic> json) {
    id = json['pharmaceuticalCompany']['_id'];
    name = json['pharmaceuticalCompany']['name'];
    coverPicture = json['pharmaceuticalCompany']['coverPicture'];
    licenceNumber = json['pharmaceuticalCompany']['licenceNumber'];
    dispoHourStart = DateTime.parse(json['pharmaceuticalCompany']['dispoHourStart']);
    dispoHourEnd = DateTime.parse(json['pharmaceuticalCompany']['dispoHourEnd']);
    workDays = json['pharmaceuticalCompany']['workDays'];
    //owner = User.ownerfromJson(json['pharmaceuticalCompany']['owner']);
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