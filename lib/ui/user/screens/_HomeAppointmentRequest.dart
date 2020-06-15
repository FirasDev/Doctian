import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:hello_world/ui/user/screens/_HomeAnalyse.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/_HomePrescription.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserAppointmentRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeAppointmentRequest extends StatefulWidget {
  @override
  _HomeAppointmentRequestState createState() => _HomeAppointmentRequestState();
}

class _HomeAppointmentRequestState extends State<HomeAppointmentRequest> {
  List<Appointment> appointments = [];
  void loadAppointments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    var jsonResponse = null;
    var response = await http.get(API_URL + "/patient/appointments/history",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    print("APi Response Status : " + response.statusCode.toString());
    print("APi Response : " + response.body.toString());
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      // AppConfig(MAIN_USER: User.fromJson(jsonResponse));
      // AppConfig.MAIN_USER = User.fromJson(jsonResponse);
      // print("User Password : " + AppConfig.MAIN_USER.phoneNumber);
      if (jsonResponse != null) {
        setState(() {
          appointments = (jsonResponse as List)
              .map((data) => new Appointment.patientFromJson(data))
              .toList();
        });
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Color.fromRGBO(110, 120, 247, 1),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.account_circle),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return UserHome();
                                }));
                              }),
                          Text(
                            "Welcome, " +
                                AppConfig.MAIN_PATIENT.name.capitalize() +
                                " " +
                                AppConfig.MAIN_PATIENT.lastName.capitalize(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.notifications),
                        color: Colors.white,
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //FlatButton(onPressed: () {}, child: Text("Notes")),
                //FlatButton(onPressed: () {}, child: Text("Prescription")),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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

                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             HomeNotes()),
                                  //     ModalRoute.withName("/Home"));

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, a1, a2) =>
                                              HomeNotes()),
                                      ModalRoute.withName("/Home"));
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
                    )),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                        'assets/images/btn_ic_med.png')),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //       pageBuilder: (_, a1, a2) =>
                                  //           HomePrescription()),
                                  // );

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, a1, a2) =>
                                              HomePrescription()),
                                      ModalRoute.withName("/Home"));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Medicines")
                      ],
                    )),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                        'assets/images/btn_ic_diag.png')),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //       pageBuilder: (_, a1, a2) =>
                                  //           HomeAnalyse()),
                                  // );

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, a1, a2) =>
                                              HomeAnalyse()),
                                      ModalRoute.withName("/Home"));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Digonostic")
                      ],
                    )),
              ],
            ),
            UserAppointmentRequest(
              appointments: appointments,
            )
            // (appointments.length != 0)
            //     ? UserAppointmentRequest(
            //         appointments: appointments,
            //       )
            //     : Container(
            //         margin: EdgeInsets.all(10.0),
            //         //height: 250,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(8),
            //             border: Border.all(width: 1.0, color: Colors.grey[200])),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: <Widget>[
            //             Expanded(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   SizedBox(
            //                     height: 20,
            //                   ),
            //                   Text("No Appointment To Load",
            //                       style: TextStyle(
            //                         fontSize: 20.0,
            //                         fontFamily: 'Raleway',
            //                         fontWeight: FontWeight.w400,
            //                       )),
            //                   SizedBox(
            //                     height: 20,
            //                   ),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       )
          ],
        ),
      ),
    );
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
