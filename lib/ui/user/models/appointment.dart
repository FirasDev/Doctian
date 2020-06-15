import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:flutter/foundation.dart';

class Appointment {
  String id;
  DateTime appointmentDate;
  String appointmentStatus;
  String detailsProvidedByPatient;
  Patient patient;
  Doctor doctor;


  Appointment({
    this.appointmentDate,
    this.appointmentStatus,
    this.detailsProvidedByPatient,
    this.patient,
    this.doctor,

  });

  // factory Appointment.fromJson(Map<String, dynamic> json) {
  //   return Appointment(
  //     appointmentDate: json['appointmentDate'] as String, 
  //     appointmentStatus: json['appointmentStatus'] as String, 
  //     detailsProvidedByPatient: json['detailsProvidedByPatient'] as String, 
  //     patient: Patient.fromJson(json['patient']),
  //     );
  // }

  Appointment.patientFromJson(Map<String, dynamic> json) {
      id = json['_id'];
      appointmentDate = DateTime.parse(json['appointmentDate']);
      appointmentStatus = json['appointmentStatus'];
      detailsProvidedByPatient = json['detailsProvidedByPatient'];
      doctor = Doctor.fromJson(json['doctor']);
    }

  Appointment.fromJson(Map<String, dynamic> json) {
    appointmentDate = DateTime.parse(json['appointmentDate']);
    appointmentStatus = json['appointmentStatus'];
    detailsProvidedByPatient = json['detailsProvidedByPatient'];
    patient = Patient.fromJson(json['patient']);
    //doctor = Doctor.fromJson(json['doctor']);
    //
    //createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentStatus'] = this.appointmentStatus;
    data['detailsProvidedByPatient'] = this.detailsProvidedByPatient;
    data['patient'] = this.patient;
    //data['doctor'] = this.doctor;
    return data;
  }

  Appointment.fromJsonDoctor(Map<String, dynamic> json) {
    id = json['_id'];
    appointmentDate = DateTime.parse(json['appointmentDate']);
    appointmentStatus = json['appointmentStatus'];
    detailsProvidedByPatient = json['detailsProvidedByPatient'];
    patient = Patient.fromJson(json['patient']);
    //doctor = Doctor.fromJson(json['doctor']);
    //
    //createDate = DateTime.parse(json['createDate']);
  }

  Map<String, dynamic> toJsonDoctor() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentStatus'] = this.appointmentStatus;
    data['detailsProvidedByPatient'] = this.detailsProvidedByPatient;
    data['patient'] = this.patient;
    //data['doctor'] = this.doctor;
    return data;
  }
}