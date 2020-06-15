import 'package:flutter/material.dart';
import 'package:hello_world/ui/animations/FadeAnimation.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/config/_AppValication.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditPatientProfile extends StatefulWidget {
  @override
  _EditPatientProfileState createState() => _EditPatientProfileState();
}

class _EditPatientProfileState extends State<EditPatientProfile> {
  Dialogs dialog = new Dialogs();
  String textModification = "Confirm Modification";
  String dropdownValue;
  DateTime selectedDate;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController idCarteController = new TextEditingController();
  final TextEditingController cnssController = new TextEditingController();
  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  @override
  void initState() {
    super.initState();
    nameController.text = AppConfig.MAIN_PATIENT.name;
    lastNameController.text = AppConfig.MAIN_PATIENT.lastName;
    idCarteController.text = AppConfig.MAIN_PATIENT.cin;
    dropdownValue = AppConfig.MAIN_PATIENT.gender;
    cnssController.text = AppConfig.MAIN_PATIENT.cnssNumber;
    selectedDate = AppConfig.MAIN_PATIENT.dateOfBirth;
  }

  editPatientProfile(String name, String lastname, String gender,
      String idCarte, String cnssNumber, DateTime date) async {
    print("Enter CompRegister");
    // var str = json.encode(date, toEncodable: myEncode);
    // print("Enter CompRegister : "+str);
    Map data = {
      'name': name,
      'lastName': lastname,
      'gender': gender,
      'cin': idCarte,
      'cnssNumber': cnssNumber,
      'dateOfBirth': date.toIso8601String(),
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.patch(API_URL + "/patient/me",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    //AppConfig.MAIN_PATIENT = Patient.fromJson(jsonResponse);
    print(jsonResponse.toString());
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      AppConfig.MAIN_PATIENT = Patient.fromJson(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          textModification = "Modification Done";
        });
        dialog.information(context, "Modification Success",
            "Your account has been successfully modified.");
      }
    } else {
      setState(() {
        textModification = "Modification FAIL";
        dialog.information(
            context, "Modification Fail", "Something went Wrong!! try again.");
      });
    }
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
                    ),
                    Positioned(
                      top: 35,
                      left: 10,
                      //width: width + 20,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, a1, a2) => UserHome()),
                                );
                              }),
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
                      "Edit Profile",
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
                            child: TextField(
                              controller: nameController,
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
                                  hintText: "First Name",
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: lastNameController,
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
                                  hintText: "Last Name",
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(110, 120, 247, 0.5))),
                              padding: EdgeInsets.only(right: 20, left: 40),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 26,
                                underline: SizedBox(),
                                elevation: 16,
                                style: TextStyle(color: Colors.deepPurple),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
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
                              controller: idCarteController,
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
                                  hintText: "ID Carte Number",
                                  prefixIcon: Icon(
                                    Icons.verified_user,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: cnssController,
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
                                  hintText: "CNSS Number",
                                  prefixIcon: Icon(
                                    Icons.card_travel,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
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
                                color: selectedDate == null
                                    ? Color.fromRGBO(110, 120, 247, 0.5)
                                    : Color.fromRGBO(110, 120, 247, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("Select Date");
                                  _selectDate();
                                },
                                child: Center(
                                  child: Text(
                                    _textDate(selectedDate),
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
                        child: GestureDetector(
                          onTap: () {
                            print("Container clicked");
                            // completeRegister(
                            //     nameController.text,
                            //     lastNameController.text,
                            //     idCarteController.text,
                            //     cnssController.text,
                            //     selectedDate);
                            if (!AppValidation.namesValidation(
                                nameController.text)) {
                              dialog.information(context, "Someting Went Wrong",
                                  "Please Check Your Input (Name).");
                            } else {
                              if (!AppValidation.namesValidation(
                                  lastNameController.text)) {
                                dialog.information(
                                    context,
                                    "Someting Went Wrong",
                                    "Please Check Your Input (LastName).");
                              } else {
                                print("AppValidation.idCardValidation : " +
                                    AppValidation.idCardValidation(
                                            idCarteController.text)
                                        .toString());
                                if (!AppValidation.idCardValidation(
                                    idCarteController.text)) {
                                  dialog.information(
                                      context,
                                      "Someting Went Wrong",
                                      "Please Check Your Input (ID Card Number).");
                                } else {
                                  if (!AppValidation.cnssValidation(
                                      cnssController.text)) {
                                    dialog.information(
                                        context,
                                        "Someting Went Wrong",
                                        "Please Check Your Input (CNSS Number).");
                                  } else {
                                    editPatientProfile(
                                        nameController.text,
                                        lastNameController.text,
                                        dropdownValue,
                                        idCarteController.text,
                                        cnssController.text,
                                        selectedDate);
                                  }
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              textModification,
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

  Future<void> _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(1920, 1),
        lastDate: new DateTime.now());
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _textDate(DateTime date) {
    if (date != null) {
      return "Date : " +
          date.year.toString() +
          "/" +
          date.month.toString() +
          "/" +
          date.day.toString();
    }
    return "Select Date";
  }
}
