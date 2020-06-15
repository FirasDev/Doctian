import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/notificationRequest.dart';
import 'package:hello_world/ui/user/models/perscription.dart';
import 'package:hello_world/ui/user/screens/_HomeAnalyse.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/widgets/PharmacyMap.dart';
import 'package:hello_world/ui/user/screens/widgets/Statistics.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserFinishedRequests.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserPerscriptions.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRequests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class HomePrescription extends StatefulWidget {
  @override
  _HomePrescriptionState createState() => _HomePrescriptionState();
}

class _HomePrescriptionState extends State<HomePrescription> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<Perscription> perscriptions = [];
  void loadPerscriptions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    var jsonResponse = null;
    var response = await http.get(API_URL + "/patient/perscriptions/",
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
          perscriptions = (jsonResponse as List)
              .map((data) => new Perscription.fromJson(data))
              .toList();
        });
        print("-------------> " + perscriptions.length.toString());
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  Future updateNotification(state) async {
    String apiUrl =
        API_URL + '/notification/' + AppConfig.MAIN_PATIENT.id + '/' + state;
    Response response = await put(apiUrl, headers: {}, body: {});
    print("Result: ${response.body}");
    return json.decode(response.body);
  }

  Future<List<NotificationRequest>> getPending() async {
    final String pendingpostsURL =
        API_URL + "/notifications/" + AppConfig.MAIN_PATIENT.id;

    Response res = await get(pendingpostsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<NotificationRequest> posts = body
          .map(
            (dynamic item) => NotificationRequest.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  @override
  void initState() {
    super.initState();
    loadPerscriptions();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserHome()),
                                );
                              }),
                          Text(
                            "Welcome, " +
                                AppConfig.MAIN_PATIENT.name +
                                " " +
                                AppConfig.MAIN_PATIENT.lastName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: getPending(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<NotificationRequest>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data[0].state == "true") {
                              return IconButton(
                                  icon: Icon(Icons.notifications),
                                  color: Colors.red,
                                  onPressed: () {
                                    updateNotification("false");

                                    _showNotificationWithDefaultSound();
                                    setState(() {});
                                  });
                            } else {
                              return IconButton(
                                  icon: Icon(Icons.notifications),
                                  color: Colors.white,
                                  onPressed: () {});
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
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
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                        'assets/images/btn_ic_doc.png')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            HomeNotes()),
                                  );
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
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                        'assets/images/btn_ic_med.png')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            HomePrescription()),
                                  );
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
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            HomeAnalyse()),
                                  );
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
            UserPrescriptions(
              prescriptions: perscriptions,
            )
          ],
        ),
      ),
    );
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Doctian notification',
      'Your drug request was accepted',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future onSelectNotification(String payload) async {}
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
