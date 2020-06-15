import 'package:flutter/material.dart';
import 'package:hello_world/covid/ui/covidMain.dart';
import 'package:hello_world/covid/ui/dashboard.dart';
import 'package:hello_world/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/screens/widgets/_DoctorProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserAnalysis.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserAppointment.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserAppointmentRequest.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserMakeRequest.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserNotes.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserPerscriptions.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRequests.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserResponses.dart';
import 'package:hello_world/ui/user/screens/widgets/chatbot/_chatScreen.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_createNotes.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_DoctorAppointments.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_checkAnalysisProcessByDoctor.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_createAnalysisRequestByDoctor.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_createPerscription.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_doctorAppointmentsHistory.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_myPatientsList.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_selectPatientForDiagnostics.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_selectPatientForMedicalFile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/fab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/ui/user/MyHomePage.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_myProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_checkMedicalFile.dart';

//Notification handling
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:hello_world/ui/user/services/push_notifications_service.dart';
import 'package:hello_world/ui/user/services/locator.dart';

class HomeScreen extends StatefulWidget {
  static bool isCreatingAnalysis;
  static bool isCreatingPerscription;
  static bool isCheckingAnalysis;
  static bool isCheckAppointmentHistory;
  static bool isCheckingAppointments;
  static bool isCreatingNotes;
  static bool isCheckingMedicalFile;
  static Patient homePatient;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final PushNotificationService _pushNotificationService =
    locator<PushNotificationService>();

Future handleStartUpLogic() async {
  await _pushNotificationService.initialise();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String userName = AppConfig().getConnectedDoctor().name.capitalize() +
      " " +
      AppConfig().getConnectedDoctor().lastName.capitalize();
  bool docIsCreatingAnalysis;
  bool docIsCreatingPerscription;
  bool docIsCheckingAnalysis;
  bool docIsCheckAppointmentHistory;
  bool docIsCheckingAppointments;
  bool docIsCreatingNotes;
  bool docIsCheckingMedicalFile;
  Patient myPatient;
  Animation<double> _animation;
  AnimationController _controller;
  int notificationCounter;
  @override
  void initState() {
    _pushNotificationService.initialise();
    docIsCreatingAnalysis = HomeScreen.isCreatingAnalysis;
    docIsCreatingPerscription = HomeScreen.isCreatingPerscription;
    docIsCheckingAnalysis = HomeScreen.isCheckingAnalysis;
    docIsCheckAppointmentHistory = HomeScreen.isCheckAppointmentHistory;
    docIsCheckingAppointments = HomeScreen.isCheckingAppointments;
    docIsCreatingNotes = HomeScreen.isCreatingNotes;
    docIsCheckingMedicalFile = HomeScreen.isCheckingMedicalFile;
    myPatient = HomeScreen.homePatient;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  int _currentIndex = 2;
  final List<Widget> _children = [
    MyPatientsList(),
    DoctorAppointments(),
    DoctorAppointments(),
    ChatScreen(),
    ChatScreen(),
    SelectPatientForDiagnostics(),
    CreateAnalysisRequestByDoctor(),
    CreatePerscription(),
    CheckAnalysisProcessByDoctor(),
    DoctorAppointmentsHistory(),
    CreateNotes(),
    SelectPatientForMedicalFile(),
    CheckMedicalFile(),
  ];

  void setAppointmentsFilter(index) {
    setState(() {
      DoctorAppointments.appointmentIndex = index;
      _currentIndex = 2;
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (BuildContext context) {
        return new MyApp();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    //   _firebaseMessaging.getToken().then((token){
    //   print("token =" + token);
    // });

    Widget changeBoolAnalysisValue() {
      setState(() {
        docIsCreatingAnalysis = HomeScreen.isCreatingAnalysis;
        docIsCreatingPerscription = false;
        docIsCheckAppointmentHistory = false;
        docIsCheckingAnalysis = false;
        docIsCreatingNotes = false;
        docIsCheckingAppointments = false;
        docIsCheckingMedicalFile = false;
      });
      return _children[6];
    }

    Widget changeBoolPerscriptionValue() {
      setState(() {
        docIsCreatingPerscription = HomeScreen.isCreatingPerscription;
        docIsCheckAppointmentHistory = false;
        docIsCheckingAnalysis = false;
        docIsCreatingAnalysis = false;
        docIsCreatingNotes = false;
        docIsCheckingAppointments = false;
        docIsCheckingMedicalFile = false;
      });
      return _children[7];
    }

    Widget changeBoolAnalysisProcessValue() {
      setState(() {
        docIsCheckingAnalysis = HomeScreen.isCheckingAnalysis;
        docIsCheckAppointmentHistory = false;
        docIsCreatingAnalysis = false;
        docIsCreatingPerscription = false;
        docIsCreatingNotes = false;
        docIsCheckingAppointments = false;
        docIsCheckingMedicalFile = false;
      });
      return _children[8];
    }

    Widget changeBoolAppointmentHistoryValue() {
      setState(() {
        docIsCheckAppointmentHistory = HomeScreen.isCheckAppointmentHistory;
        docIsCreatingAnalysis = false;
        docIsCreatingPerscription = false;
        docIsCheckingAnalysis = false;
        docIsCreatingNotes = false;
        docIsCheckingAppointments = false;
        docIsCheckingMedicalFile = false;
      });
      return _children[9];
    }

    Widget changeBoolCreatingNotesValue() {
      setState(() {
        docIsCreatingNotes = HomeScreen.isCreatingNotes;
        docIsCreatingAnalysis = false;
        docIsCreatingPerscription = false;
        docIsCheckingAnalysis = false;
        docIsCheckingAppointments = false;
        docIsCheckAppointmentHistory = false;
        docIsCheckingMedicalFile = false;
      });
      return _children[10];
    }

    Widget changeBoolMedicalFileValue() {
      setState(() {
        docIsCheckingMedicalFile = HomeScreen.isCheckingMedicalFile;
        docIsCreatingAnalysis = false;
        docIsCreatingPerscription = false;
        docIsCheckingAnalysis = false;
        docIsCheckingAppointments = false;
        docIsCheckAppointmentHistory = false;
        docIsCreatingNotes = false;
      });
      return _children[12];
    }

    Widget loadMainWidget(index) {
      print(index);
      index == 2
          ? docIsCheckingAppointments = true
          : docIsCheckingAppointments = false;
      return _children[index];
    }

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
                            icon: Icon(Icons.power_settings_new),
                            color: Colors.white,
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              AppConfig.MAIN_USER = null;
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePage()),
                                  (Route<dynamic> route) => false);
                            }),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.85,
                          child: new AutoSizeText(
                            "Welcome, " + userName,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  new Stack(
                    children: <Widget>[
                      new IconButton(
                          icon: Icon(FontAwesomeIcons.virus),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Covid()));
                          }),
                      new Positioned(
                        right: 11,
                        top: 11,
                        child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            )),
                      )
                    ],
                  ),
                  PushNotificationService(),
                ],
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyProfile()));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Profile".toUpperCase())
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
                                        'assets/images/medical_file.png')),
                                onTap: () {
                                  setState(() {
                                    this._currentIndex = 11;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Text("Medical File".toUpperCase())
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
                                  setState(() {
                                    this._currentIndex = 5;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Diagnostics".toUpperCase())
                      ],
                    )),
              ],
            ),

            if (docIsCreatingAnalysis == true)
              changeBoolAnalysisValue()
            else if (docIsCreatingPerscription == true)
              changeBoolPerscriptionValue()
            else if (docIsCheckingAnalysis == true)
              changeBoolAnalysisProcessValue()
            else if (docIsCheckAppointmentHistory == true)
              changeBoolAppointmentHistoryValue()
            else if (docIsCreatingNotes == true)
              changeBoolCreatingNotesValue()
            else if (docIsCheckingMedicalFile == true)
              changeBoolMedicalFileValue()
            else
              loadMainWidget(_currentIndex)
            //DoctorAppointments(),
            //UserNotes()
            //UserPrescriptions()
            //UserAnalysis()
            //UserMakeRequest()
            //UserRequests()
            //UserResponses()
            //UserAppointment()
            //UserAppointmentRequest()
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height / 14.5,
        color: Color(0xff6e78f7),
        backgroundColor: Colors.grey[50],
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeIn,
        index: 2,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(FontAwesomeIcons.home, size: 25),
          ),
          Icon(FontAwesomeIcons.comments, size: 25),
          Icon(FontAwesomeIcons.medkit, size: 25),
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(FontAwesomeIcons.robot, size: 25),
          )
        ],
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
      ),
      floatingActionButton: Visibility(
        //visible: docIsCheckingAppointments,
        visible: true,
        child: ExpandedAnimationFab(
          items: [
            FabItem(
              "Accepted",
              FontAwesomeIcons.check,
              onPress: () {
                _controller.reverse();
                setAppointmentsFilter(0);
              },
            ),
            FabItem(
              "Rejected",
              FontAwesomeIcons.times,
              onPress: () {
                _controller.reverse();
                setAppointmentsFilter(1);
              },
            ),
            FabItem(
              "Pending",
              FontAwesomeIcons.spinner,
              onPress: () {
                _controller.reverse();
                setAppointmentsFilter(2);
              },
            ),
            FabItem(
              "Waiting",
              FontAwesomeIcons.ellipsisH,
              onPress: () {
                _controller.reverse();
                setAppointmentsFilter(3);
              },
            ),
            FabItem(
              "Display All",
              FontAwesomeIcons.timesCircle,
              onPress: () {
                _controller.reverse();
                setAppointmentsFilter(4);
              },
            ),
          ],
          animation: _animation,
          onPress: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
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
