import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/laboratory.dart';

class Analysis {
  String id;
  String description;
  String status;
  String category;
  DateTime dateAnalyse;
  String patient;
  Doctor doctor;
  Laboratory laboratory;
  List<String> analysisResult;

  Analysis({
    this.id,
    this.description,
    this.status,
    this.category,
    this.dateAnalyse,
    this.patient,
    this.doctor,
    this.laboratory,
    this.analysisResult,
  });

  Analysis.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    status = json['status'];
    category = json['category'];
    dateAnalyse = DateTime.parse(json['dateAnalyse']);
    laboratory = json['laboratory'];
    analysisResult = json['analysisResult'];
    patient = json['patient'];
    doctor = Doctor.fromJson(json['doctor']);
  }

  Analysis.fromJsonDoctor(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    status = json['status'];
    category = json['category'];
    dateAnalyse = DateTime.parse(json['dateAnalyse']);
    laboratory = json['laboratory'];
    analysisResult = json['analysisResult'];
    patient = json['patient'];
    doctor = Doctor.fromJsonOptional(json['doctor']);
  }

  Analysis.patientFromJson(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    status = json['status'];
    category = json['category'];
    dateAnalyse = DateTime.parse(json['dateAnalyse']);
    analysisResult = json['analysisResult'];
    doctor = Doctor.fromJson(json['doctor']);
    laboratory =  Laboratory.fromJson(json['laboratory']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['description'] = this.description;
    data['status'] = this.status;
    data['category'] = this.category;
    data['dateAnalyse'] = this.dateAnalyse;
    data['laboratory'] = this.laboratory;
    data['analysisResult'] = this.analysisResult;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
