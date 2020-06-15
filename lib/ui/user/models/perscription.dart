import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/patient.dart';

class Perscription {
  String id;
  String perscriptionDescription;
  String ipfsUrl;
  String patient;
  Doctor doctor;

  Perscription({
    this.perscriptionDescription,
    this.ipfsUrl,
    this.patient,
    this.doctor,
  });

  Perscription.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    perscriptionDescription = json['perscriptionDescription'];
    ipfsUrl = json['ipfsUrl'];
    patient = json['patient'];
    doctor = Doctor.fromJson(json['doctor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['perscriptionDescription'] = this.perscriptionDescription;
    data['ipfsUrl'] = this.ipfsUrl;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
