import 'package:hello_world/ui/user/models/medicamentRequest.dart';
import 'package:hello_world/ui/user/models/pharmacy.dart';

class Stat {
  String id;
  int count;

  Stat({
    this.id,
    this.count
  
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      id: json['_id'] as String,
      count: json['count'] as int,
    );
  }
}