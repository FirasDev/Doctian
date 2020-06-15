import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/notes.dart';
import 'package:hello_world/ui/user/models/perscription.dart';
import 'package:hello_world/ui/user/models/users.dart';

class Doctor {
  String id;
  String name;
  String lastName;
  String specialty;
  String cin;
  String nationality;
  String medicalLicenseNumber;
  DateTime dispoHourStart;
  DateTime dispoHourEnd;
  String workDays;
  DateTime startWorkDate;
  double fee;
  List<Notes> notes;
  List<Perscription> perscriptions;
  List<Analysis> analyses;
  User owner;

  Doctor({
    this.id,
    this.name,
    this.lastName,
    this.specialty,
    this.cin,
    this.medicalLicenseNumber,
    this.nationality,
    this.dispoHourStart,
    this.dispoHourEnd,
    this.workDays,
    this.startWorkDate,
    this.fee,
    this.notes,
    this.owner
  });

    Doctor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastName = json['lastName'];
    specialty = json['specialty'];
    cin = json['cin'];
    medicalLicenseNumber = json['medicalLicenseNumber'];
    nationality = json['nationality'];
    dispoHourStart = DateTime.parse(json['dispoHourStart']);
    dispoHourEnd = DateTime.parse(json['dispoHourEnd']);
    startWorkDate = DateTime.parse(json['startWorkDate']);
    fee = json['fee'];
    workDays = json['workDays'];
    owner = User.ownerfromJson(json['owner']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['specialty'] = this.specialty;
    data['cin'] = this.cin;
    data['medicalLicenseNumber'] = this.medicalLicenseNumber;
    data['nationality'] = this.nationality;
    data['dispoHourStart'] = this.dispoHourStart;
    data['dispoHourEnd'] = this.dispoHourEnd;
    data['dispoHourEnd'] = this.dispoHourEnd;
    return data;
  }


Doctor.fromJsonOptional(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastName = json['lastName'];
    specialty = json['specialty'];
    cin = json['cin'];
    medicalLicenseNumber = json['medicalLicenseNumber'];
    nationality = json['nationality'];
    owner = User.ownerfromJson(json['owner']);
  }

  Map<String, dynamic> toJsonOptional() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['specialty'] = this.specialty;
    data['cin'] = this.cin;
    data['medicalLicenseNumber'] = this.medicalLicenseNumber;
    data['nationality'] = this.nationality;
    return data;
  }

  Doctor.doctorFromJson(Map<String, dynamic> json) {
    id = json['doctor']['_id'];
    name = json['doctor']['name'];
    lastName = json['doctor']['lastName'];
    specialty = json['doctor']['specialty'];
    cin = json['doctor']['cin'];
    medicalLicenseNumber = json['doctor']['medicalLicenseNumber'];
    nationality = json['doctor']['nationality'];
    dispoHourStart = DateTime.parse(json['doctor']['dispoHourStart']);
    dispoHourEnd = DateTime.parse(json['doctor']['dispoHourEnd']);
    startWorkDate = DateTime.parse(json['doctor']['startWorkDate']);
    fee = json['doctor']['fee'];
    workDays = json['doctor']['workDays'];
  }

  bool workDay(String dy) {
    List<String> days = workDays.split(',');
    bool result = false;
    days.forEach((day) {
      if (day?.toLowerCase() == dy?.toLowerCase()) {
        result = true;
      }
    });
    return result;
  }

}