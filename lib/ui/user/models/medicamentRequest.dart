import 'package:hello_world/ui/user/models/medicamentResponse.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/models/perscription.dart';

class MedicamentRequest {
  String id;
  String medicament;
  String state;
  Patient patient;
  Perscription perscription;
  List<MedicamentResponse> medicamentResponses = new List<MedicamentResponse>();

  MedicamentRequest({
    this.id,
    this.medicament,
    this.state,
    this.patient,
    this.perscription,
    this.medicamentResponses,
  });
}