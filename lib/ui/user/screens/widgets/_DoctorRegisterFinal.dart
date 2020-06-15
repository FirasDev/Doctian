import 'package:flutter/material.dart';
import 'package:hello_world/ui/animations/FadeAnimation.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/screens/widgets/_DialogSelectDays.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/ui/user/config/_AppValication.dart';
import 'package:hello_world/ui/user/config/config.dart';

class DoctorRegisterFinal extends StatefulWidget {
  final Doctor doctor;
  DoctorRegisterFinal({Key key, @required this.doctor}) : super(key: key);

  @override
  _DoctorRegisterFinalState createState() => _DoctorRegisterFinalState();
}

class _DoctorRegisterFinalState extends State<DoctorRegisterFinal> {
  Dialogs dialog = new Dialogs();
  String dropdownValue = 'FAMILY MEDICINE';
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController idCarteController = new TextEditingController();
  final TextEditingController feeController = new TextEditingController();
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  TimeOfDay selectedTimeStart;
  Future<void> _selectedTimeStart() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTimeStart = picked;
      });
    }
  }

  completeRegister(Doctor doc, List<String> daysOfWorks, TimeOfDay selectedTimeEnd,
      TimeOfDay selectedTimeStart, String fee) async {
    //print("Enter CompRegister" + data.medicalLicenseNumber.toString());
    // var str = json.encode(date, toEncodable: myEncode);
    // print("Enter CompRegister : "+str);

    String daysOfWrk = daysOfWorks.toString();
    var long2 = double.tryParse(fee);
    daysOfWrk = daysOfWrk.replaceAll('[', '');
    daysOfWrk = daysOfWrk.replaceAll(']', '');
    final now = new DateTime.now();
    DateTime startTime  = new DateTime(now.year, now.month, now.day, selectedTimeStart.hour, selectedTimeStart.minute);
    DateTime endTime  = new DateTime(now.year, now.month, now.day, selectedTimeEnd.hour, selectedTimeEnd.minute);
    print(daysOfWrk);
    print(endTime);
    print(startTime);
    print(long2);


    Map data = {
      'name': doc.name,
      'lastName': doc.lastName,
      'cin': doc.cin,
      'medicalLicenseNumber': doc.medicalLicenseNumber,
      'specialty': doc.specialty,
      'startWorkDate': doc.startWorkDate.toIso8601String(),
      'workDays': daysOfWrk,
      'fee': long2,
      'dispoHourStart': startTime.toIso8601String(),
      'dispoHourEnd': endTime.toIso8601String(),
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(API_URL + "/users/register",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    print(jsonResponse.toString());
    if (response.statusCode == 201) {
      AppConfig.MAIN_DOCTOR = Doctor.fromJson(jsonResponse);

      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    (Route<dynamic> route) => false);
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }

    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => DoctorRegisterFinal(
    //               doctor: data,
    //             )),
    //     (Route<dynamic> route) => false);
  }

  TimeOfDay selectedTimeEnd;
  Future<void> _selectedTimeEnd() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTimeEnd = picked;
      });
    }
  }

  String _textDateStart(TimeOfDay date) {
    if (date != null) {
      return "Date : " + date.format(context);
      // date.year.toString() +
      // "/" +
      // date.month.toString() +
      // "/" +
      // date.day.toString();
    }
    return "Select Start Work Time";
  }

  String _textDateEnd(TimeOfDay date) {
    if (date != null) {
      return "Date : " + date.format(context);
      // date.year.toString() +
      // "/" +
      // date.month.toString() +
      // "/" +
      // date.day.toString();
    }
    return "Select End Work Time";
  }

  List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> selectedDays = [];

  String _textSelectDay(List<String> selectedDays) {
    if (selectedDays.length != 0) {
      return "DONE";
      // date.year.toString() +
      // "/" +
      // date.month.toString() +
      // "/" +
      // date.day.toString();
    }
    return "Select Days";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -120,
                      width: width,
                      height: 250,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 250,
                      top: -90,
                      width: width + 20,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Complete Profile",
                      style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 139, 198, 0.3),
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                color: selectedTimeStart == null
                                    ? Color.fromRGBO(110, 120, 247, 0.5)
                                    : Color.fromRGBO(110, 120, 247, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("Select End Work Date");
                                  _selectedTimeStart();
                                },
                                child: Center(
                                  child: Text(
                                    _textDateStart(selectedTimeStart),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                color: selectedTimeEnd == null
                                    ? Color.fromRGBO(110, 120, 247, 0.5)
                                    : Color.fromRGBO(110, 120, 247, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("Select Start Work Date");
                                  _selectedTimeEnd();
                                },
                                child: Center(
                                  child: Text(
                                    _textDateEnd(selectedTimeEnd),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                color: selectedDays.length == 0
                                    ? Color.fromRGBO(110, 120, 247, 0.5)
                                    : Color.fromRGBO(110, 120, 247, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SelectWorkDay(
                                            days: allDays,
                                            selectedDays: selectedDays,
                                            onSelectedDaysListChanged: (days) {
                                              setState(() {
                                                selectedDays = days;
                                              });
                                              print(selectedDays);
                                            });
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    _textSelectDay(selectedDays),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: feeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(width: 0.8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromRGBO(110, 120, 247, 0.5)),
                                  ),
                                  hintText: "Fee",
                                  prefixIcon: Icon(
                                    Icons.card_travel,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            print("Container clicked");
                            print(selectedTimeStart);
                            if (selectedDays.length > 0) {}
                            completeRegister(
                                widget.doctor,
                                selectedDays,
                                selectedTimeStart,
                                selectedTimeEnd,
                                feeController.text);
                          },
                          child: Center(
                            child: Text(
                              "Complete Register",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
