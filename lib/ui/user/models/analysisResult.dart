import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/laboratory.dart';

class AnalysisResult {
  String id;
  String description;
  String ipfsURL;
  Analysis analysis;
  String patient;
  String doctor;

  AnalysisResult({
    this.id,
    this.description,
    this.ipfsURL,
    this.analysis,
    this.patient,
    this.doctor,
  });


  AnalysisResult.fromJsonDoctor(Map<String, dynamic> json) {
    id = json['_id'];
    description = json['description'];
    ipfsURL = json['ipfsUrl'];
    analysis = Analysis.fromJsonDoctor(json['analysis']);
    patient = json['patient'];
    doctor = json['doctor'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['description'] = this.description;
    data['ipfsUrl'] = this.ipfsURL;
    data['analysis'] = this.analysis;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
