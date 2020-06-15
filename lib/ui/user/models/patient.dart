import 'package:hello_world/ui/user/models/notes.dart';
import 'package:hello_world/ui/user/models/users.dart';

class Patient {
  String id;
  String name;
  String lastName;
  String gender;
  String cin;
  String nationality;
  String cnssNumber;
  DateTime dateOfBirth;
  List<Notes> notes;
  User owner;

  Patient(
      {this.id,
      this.name,
      this.lastName,
      this.gender,
      this.cin,
      this.cnssNumber,
      this.dateOfBirth,
      this.nationality,
      this.owner});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastName = json['lastName'];
    gender = json['gender'];
    cnssNumber = json['cnssNumber'];
    dateOfBirth = DateTime.parse(json['dateOfBirth']);
    cin = json['cin'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['cnssNumber'] = this.cnssNumber;
    data['cin'] = this.cin;
    data['dateOfBirth'] = this.dateOfBirth.toIso8601String();
    data['nationality'] = this.nationality;
    return data;
  }

  Patient.patientFromJson(Map<String, dynamic> json) {
    id = json['patient']['_id'];
    name = json['patient']['name'];
    lastName = json['patient']['lastName'];
    gender = json['patient']['gender'];
    cnssNumber = json['patient']['cnssNumber'];
    dateOfBirth = DateTime.parse(json['patient']['dateOfBirth']);
    cin = json['patient']['cin'];
    nationality = json['patient']['nationality'];
  }
  
  Patient.fromJsonDoctor(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastName = json['lastName'];
    cnssNumber = json['cnssNumber'];
    cin = json['cin'];
    nationality = json['nationality'];
    print(json["owner"]);
    owner = User.ownerfromJson(json["owner"]);
  }

  Map<String, dynamic> toJsonDoctor() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['cnssNumber'] = this.cnssNumber;
    data['cin'] = this.cin;
    data['nationality'] = this.nationality;
    data['owner'] = this.owner;
    return data;
  }
}
