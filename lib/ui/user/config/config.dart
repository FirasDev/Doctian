import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/models/pharmaceuticalCompany.dart';
import 'package:hello_world/ui/user/models/users.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String API_URL = "http://192.168.1.26:3000";
const String IP_ADDRESS = "192.168.1.26";
const String IMG_SERVER = API_URL + "/users/img/";

enum ALLOWED_USERS {
  Patient,
  Doctor,
  PharmaceuticalCompany,
}

class AppConfig {
  static User MAIN_USER;

  static Patient MAIN_PATIENT;
  static Doctor MAIN_DOCTOR;
  static PharmaceuticalCompany MAIN_PHARMCOM;
  static Doctor SELECTED_DOCTOR;

  // AppConfig({
  //   this.MAIN_USER,
  // });

  User getMainUser() {
    return MAIN_USER;
  }

  Doctor getConnectedDoctor(){
    return MAIN_DOCTOR;
  }

  static Future<bool> checkLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    if (value == 0) {
      return Future<bool>.value(false);
    } else {
      var response = await http.get(API_URL + "/users", headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $value"
      });
      if (response.statusCode == 200) {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    }
  }

  static String dateFormat(DateTime date) {
    return new DateFormat.yMMMMd().add_Hm().format(date);
  }

  static String dateFormatAppointment(DateTime date) {
    return new DateFormat.yMMMMd().add_jm().format(date);
  }

  static String timeFormat(DateTime date) {
    return new DateFormat.jm().format(date);
  }

  static String currencyFormat() {
    return "TND";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
