import 'package:flutter/foundation.dart';

class DrugRequest {

  final String id;
  final String city;
  final String drug;
  final String state;
  final String image;
  final String response;


  DrugRequest({

    this.id,
    this.drug,
     this.city,
    this.image,
     this.state,
     this.response,

  });

  factory DrugRequest.fromJson(Map<String, dynamic> json) {
    return DrugRequest(
  
      id: json['_id'] as String,
      drug: json['medicament'] as String,
      city: json['city'] as String,
      image: json['image'] as String,
      state: json['state'] as String,
      response: json['response'] as String,
    );
  }
}