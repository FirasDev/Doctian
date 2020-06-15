import 'package:hello_world/ui/user/models/medicamentResponse.dart';
import 'package:hello_world/ui/user/models/users.dart';

class Pharmacy {
  String name;
  String dispoHourStart;
  String dispoHourEnd;
  String workDays;
  List<MedicamentResponse> medicamentResponses;
  User owner;

  Pharmacy({
    this.name,
    this.dispoHourStart,
    this.dispoHourEnd,
    this.workDays,
    this.medicamentResponses,
    this.owner
  });
}