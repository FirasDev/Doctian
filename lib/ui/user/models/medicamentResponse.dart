import 'package:hello_world/ui/user/models/medicamentRequest.dart';
import 'package:hello_world/ui/user/models/pharmacy.dart';

class MedicamentResponse {
  String id;
  String state;
  String medicamentRequest;
  String pharmacy;
  String name;
  String address;
  double distance;

  MedicamentResponse({
    this.id,
    this.name,
    this.state,
    this.medicamentRequest,
    this.pharmacy,
    this.address,
    this.distance
  
  });

  factory MedicamentResponse.fromJson(Map<String, dynamic> json) {
    return MedicamentResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      medicamentRequest: json['medicamentRequest'] as String,
      pharmacy: json['pharmacy'] as String,
      state: json['state'] as String,
      address: json['address'] as String,
      distance: json['distance'] as double
     
    );
  }
}