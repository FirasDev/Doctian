import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/screens/_HomeAppointment.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRegister.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dialogs {
  information(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text("Okay"))
            ],
          );
        });
  }

  waiting(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
          );
        });
  }

  _confirmResult(bool isConfirmed, BuildContext context) {
    if (isConfirmed) {
      print('True Confition');
      Navigator.pop(context);
    } else {
      print('False Confition');
      Navigator.pop(context);
    }
  }

  confirm(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => _confirmResult(false, context),
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () => _confirmResult(true, context),
                  child: Text("Okay"))
            ],
          );
        });
  }

  _confirmAutoAppointment(
      bool isConfirmed, BuildContext context, String id) async {
    if (isConfirmed) {
      print('True Confition');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final key = 'token';
      final value = sharedPreferences.get(key) ?? 0;
      print("Token From SP : " + value);
      var jsonResponse = null;
      var response = await http
          .post(API_URL + "/patient/doctors/appointment/" + id, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $value"
      });
      print("APi Response Status : " + response.statusCode.toString());
      print("APi Response : " + response.body.toString());
      jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(pageBuilder: (_, a1, a2) => HomeAppointment()),
              ModalRoute.withName("/Home"));
        } else {
          this.information(context, "Fail",
              "Fail status 400, Unable to Create Appointement");
        }
      } else {
        this.information(context, "Fail Connection",
            "Fail status 500, Unable to Create Appointement");
      }
    } else {
      print('False Condition');
      Navigator.pop(context);
    }
  }

  createAutoAppointment(BuildContext context, String id) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("AI Appointment Picker"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      "By Confirming this, The AI System Will send The Sooner availible Appointment..")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => _confirmAutoAppointment(false, context, id),
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () => _confirmAutoAppointment(true, context, id),
                  child: Text("Confirm"))
            ],
          );
        });
  }

/*
  void createAutoAppointment(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    var jsonResponse = null;
    var response = await http
        .post(API_URL + "/patient/doctors/appointment/" + id, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });
    print("APi Response Status : " + response.statusCode.toString());
    print("APi Response : " + response.body.toString());
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {}
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }
*/
  completeAppointement(BuildContext context, DateTime date,
      String detailsProvidedByPatient, String id) async {
    Map data = {
      'detailsProvidedByPatient': detailsProvidedByPatient,
      'appointmentDate': date.toIso8601String(),
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(API_URL + "/patient/doctor/" + id,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(pageBuilder: (_, a1, a2) => HomeAppointment()),
            ModalRoute.withName("/Home"));
      } else {
        this.information(
            context, "Fail", "Fail status 400, Unable to Create Appointement");
      }
    } else {
      this.information(context, "Fail Connection",
          "Fail status 500, Unable to Create Appointement");
    }
  }

  _confirmDeleteAction(
      bool isConfirmed, BuildContext context, String id) async {
    if (isConfirmed) {
      print('True Confition');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final key = 'token';
      final value = sharedPreferences.get(key) ?? 0;
      var jsonResponse = null;
      var response = await http.delete(API_URL + "/patient/appointments/" + id,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $value"
          });
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse == null) {
          this.information(context, "Fail Connection",
              "Fail status 400, Unable to Cancel Appointement");
        } else {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(pageBuilder: (_, a1, a2) => HomeAppointment()),
              ModalRoute.withName("/Home"));
        }
      }
    } else {
      print('False Confition');
      Navigator.pop(context);
    }
  }

  deleteAppointement(BuildContext context, String id) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Do you really want to Cancel this Appointment")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => _confirmDeleteAction(false, context, id),
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () => _confirmDeleteAction(true, context, id),
                  child: Text("Okay"))
            ],
          );
        });
  }

  appointment(
      BuildContext context, String title, DateTime date, String idDoctor) {
    final TextEditingController _textEditingController =
        new TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title + AppConfig.dateFormatAppointment(date)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: _textEditingController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write Notes, Details, ... and Confirm",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 6,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => _confirmResult(false, context),
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () {
                    _confirmResult(true, context);
                    if (_textEditingController.text.isEmpty) {
                      completeAppointement(
                          context,
                          date,
                          "Hi Doctor. This is " +
                              AppConfig.MAIN_PATIENT.name.capitalize() +
                              " " +
                              AppConfig.MAIN_PATIENT.lastName.capitalize() +
                              ". I want to confirm this appointment.",
                          idDoctor);
                    } else {
                      completeAppointement(
                          context, date, _textEditingController.text, idDoctor);
                    }
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }

  registerRoleChoose(BuildContext context, String title) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      'assets/images/btn_ic_doc.png')),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageRouteBuilder(
                                //       pageBuilder: (_, a1, a2) => HomeNotes()),
                                // );

                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UserRegister(role: 'Doctor');
                                }));
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Doctor")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      'assets/images/btn_ic_doc.png')),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageRouteBuilder(
                                //       pageBuilder: (_, a1, a2) => HomeNotes()),
                                // );
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UserRegister(role: 'Patient');
                                }));
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Patient")
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                child: Text('Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    )),
                color: Color.fromRGBO(110, 120, 247, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;
  final Widget child;

  ClipOvalShadow({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRect(child: child, clipper: this.clipper),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;

  _ClipOvalShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(0, 0));
    canvas.drawOval(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
