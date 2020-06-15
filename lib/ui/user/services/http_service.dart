import 'dart:convert';
import 'dart:io';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/analysisResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String serverUrl = API_URL;

  Future<List<Appointment>> getAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    //print('--------------------------> Enter Appointements');
    var jsonResponse = null;
    http.Response res = await http.get(serverUrl + "/doctor/appointments",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    //print("APi Response Status : " + res.statusCode.toString());
    //print("APi Response : " + res.body.toString());

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      //print("APi Response Status : " + body.toString());
      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();
      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<Appointment>> getAcceptedAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/accepted", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();

      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<Appointment>> getRejectedAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/rejected", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();

      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<Appointment>> getPendingAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/pending", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();

      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<Appointment>> getWaitingAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/waiting", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();

      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<Patient>> getMyPatientsList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http.get(serverUrl + "/doctor/patients",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Patient> patients =
          body.map((dynamic item) => Patient.fromJsonDoctor(item)).toList();

      return patients;
    } else {
      throw "Can't get patients";
    }
  }

  createAnalysisByDoctor(
      String description, String category, String patientId) async {
    Map data = {'description': description, 'category': category};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(
        serverUrl + "/doctor/patient/analysis/" + patientId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        print(jsonResponse.toString());
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  createPerscription(String description, String patientId) async {
    Map data = {'perscriptionDescription': description};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(
        serverUrl + "/doctor/patient/perscriptions/" + patientId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        print(jsonResponse.toString());
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  createNotes(String notesDetails, String patientId) async {
    Map data = {'notesDetails': notesDetails};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(
        serverUrl + "/doctor/patient/note/" + patientId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      print("sent");
      if (jsonResponse != null) {
        print(jsonResponse.toString());
      }
    } else {}
  }

  Future<List<Analysis>> getPatientAnalysisResults(String patientId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/patient/analysis/" + patientId, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Analysis> analysis =
          body.map((dynamic item) => Analysis.fromJsonDoctor(item)).toList();

      return analysis;
    } else {
      throw "Can't get patients";
    }
  }

  Future<List<Appointment>> getAppointmentsHistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/history", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Appointment> appointments =
          body.map((dynamic item) => Appointment.fromJsonDoctor(item)).toList();

      return appointments;
    } else {
      throw "Can't get appointments";
    }
  }

  rejectAppointment(String appointmentId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var jsonResponse = null;
    var response = await http.put(
        serverUrl + "/doctor/appointments/reject/" + appointmentId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        print(jsonResponse.toString());
      }
    } else {}
  }

  rescheduleAppointment(String appointmentId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var jsonResponse = null;
    var response = await http.put(
        serverUrl + "/doctor/appointments/reschedule/" + appointmentId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        print(jsonResponse.toString());
      }
    } else {}
  }

  Future<int> getAppointmnetsCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/all/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getRejectedAppointmnetsCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/rejected/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getAppointmnetsHistoryCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/history/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getPendingCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/pending/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getWaitingAppointmnetsCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/waiting/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getPerscriptionsCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/perscriptions/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<int> getUpcomingAppointmnetsCount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    http.Response res = await http
        .get(serverUrl + "/doctor/appointments/upcoming/count", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });

    if (res.statusCode == 200) {
      int body = jsonDecode(res.body);

      return body;
    } else {
      throw "Can't get appointments";
    }
  }

  Future<List<AnalysisResult>> getAnalaysisResults(String patientId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    //print('--------------------------> Enter Appointements');
    var jsonResponse = null;
    http.Response res = await http.get(serverUrl + "/doctor/laboratory/analysis/" + patientId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    //print("APi Response Status : " + res.statusCode.toString());
    //print("APi Response : " + res.body.toString());

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      //print("APi Response Status : " + body.toString());

      List<AnalysisResult> analysisResults =
          body.map((dynamic item) => AnalysisResult.fromJsonDoctor(item)).toList();

      return analysisResults;
    } else {
      throw "Can't get analysis results";
    }
  }

  Future<String> getIpfsConvertedLink(
      String ipfsUrl) async {
    Map data = {'ipfsUrl': ipfsUrl};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(
        serverUrl + "/doctor/ipfs/",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    //jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      String body = response.body;
      return body;
    } else {
      return "empty";
    }
  }



}
