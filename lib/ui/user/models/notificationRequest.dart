import 'package:flutter/foundation.dart';

class NotificationRequest {

  
  final String patient;
  final String state;



  NotificationRequest({

   this.patient,
   this.state,

  });

  factory NotificationRequest.fromJson(Map<String, dynamic> json) {
    return NotificationRequest(
  
      patient: json['patient'] as String,
      state: json['state'] as String,
      
    );
  }
}