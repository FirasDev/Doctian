import 'package:hello_world/ui/user/models/doctor.dart';

class SearchResult {
  Doctor doctor;
  double distance;

  SearchResult({this.doctor, this.distance});

  SearchResult.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    doctor = Doctor.fromJson(json['doctor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctor;
    data['distance'] = this.distance;
    return data;
  }
}
