import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/patient.dart';

class Notes {
  String id;
  String notesDetails;
  String ipfsUrl;
  String patient;
  Doctor doctor;
  DateTime createDate;

  Notes({
    this.id,
    this.notesDetails,
    this.ipfsUrl,
    this.patient,
    this.doctor,
    this.createDate,
  });

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    notesDetails = json['notesDetails'];
    ipfsUrl = json['ipfsUrl'];
    patient = json['patient'];
    //patient = Patient.fromJson(json['patient']);
    doctor = Doctor.fromJson(json['doctor']);
    createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['notesDetails'] = this.notesDetails;
    data['ipfsUrl'] = this.ipfsUrl;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    data['createDate'] = this.createDate;
    return data;
  }
}
