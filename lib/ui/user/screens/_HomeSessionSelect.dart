import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/session.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSessionSelect extends StatefulWidget {
  final Doctor doctor;
  final DateTime selectedDate;
  HomeSessionSelect(
      {Key key, @required this.doctor, @required this.selectedDate})
      : super(key: key);
  @override
  _HomeSessionSelectState createState() => _HomeSessionSelectState();
}

class _HomeSessionSelectState extends State<HomeSessionSelect> {
  Dialogs dialog = new Dialogs();
  String yearsExperience(DateTime date) {
    if (DateTime.now().year == date.year)
      return "1";
    else
      return (DateTime.now().year - date.year).toString();
  }

  String workTime(DateTime start, DateTime end) {
    return DateFormat.jm().format(start) + " - " + DateFormat.jm().format(end);
  }

  Color getStatusColor(bool status) {
    if (status == false) {
      return Colors.green;
    } else {
      return Colors.redAccent;
    }
  }

  IconData getStatusIcon(bool status) {
    if (status == false) {
      return Icons.done;
    } else {
      return Icons.close;
    }
  }

  Widget getStatusWidget(bool status, DateTime date) {
    if (status == false) {
      return InkWell(
        child: Icon(getStatusIcon(status)),
        onTap: () {
          String myTime = DateFormat('HH:mm:ss').format(date);
          myTime += ".000Z";
          String myDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
          DateTime parsedDate = DateTime.parse(myDate + " " + myTime);

          print("Date : " + date.toString());
          print("Date : " + myDate + " " + myTime);
          print("Selected Date : " + widget.selectedDate.toString());

          //print(parsedDate.toString());

          //DateTime newDate;
          dialog.appointment(context, "", parsedDate, widget.doctor.id);
        },
      );
    } else {
      return Icon(getStatusIcon(status));
    }
  }

  List<SessionEvent> sessions = [];
  void loadSessionsDay() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    var jsonResponse = null;
    var response = await http.get(
        API_URL +
            "/patient/doctor/hours/" +
            widget.doctor.id +
            "/" +
            DateFormat('yyyyMMdd').format(widget.selectedDate),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
    print("APi Response Status : " + response.statusCode.toString());
    print("APi Response : " + response.body.toString());
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      // AppConfig(MAIN_USER: User.fromJson(jsonResponse));
      // AppConfig.MAIN_USER = User.fromJson(jsonResponse);
      // print("User Password : " + AppConfig.MAIN_USER.phoneNumber);
      if (jsonResponse != null) {
        setState(() {
          sessions = (jsonResponse as List)
              .map((data) => new SessionEvent.fromJson(data))
              .toList();
        });
      }

      print("----------------> " + sessions.length.toString());
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  void initState() {
    loadSessionsDay();
    super.initState();
  }

  _buildSessions(BuildContext context, SessionEvent session, int index) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: Colors.grey[200])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
                "Session " +
                    index.toString() +
                    " Time : " +
                    AppConfig.timeFormat(session.session),
                style: TextStyle(
                  fontSize: 20.0,
                  color: (session.status)
                      ? Color.fromRGBO(0, 0, 0, 0.4)
                      : Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                )),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: getStatusColor(session.status),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1.0, color: Colors.blue[200])),
            child: getStatusWidget(session.status, session.session),
          )
        ],
      ),
    );
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
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1.0, color: Colors.grey[200])),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          //width: 100,
                          margin: EdgeInsets.all(20),
                          child: Text(widget.doctor.owner.role)),
                      Container(
                        transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                            border:
                                Border.all(width: 6.0, color: Colors.white)),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    IMG_SERVER + widget.doctor.owner.avatar)),
                            Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Text(widget.doctor.name.capitalize() +
                                    " " +
                                    widget.doctor.lastName.capitalize())),
                          ],
                        ),
                      ),
                      Container(
                         // width: 100,
                          margin: EdgeInsets.all(20),
                          child: Text(widget.doctor.owner.city)),
                    ],
                  ),
                  Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                          "Phone Number : " + widget.doctor.owner.phoneNumber)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                              //color: Color.fromRGBO(49, 39, 79, 1),
                              border: Border.all(
                                width: 1.0,
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              widget.doctor.specialty.capitalize(),
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                              //color: Color.fromRGBO(49, 39, 79, 1),
                              border: Border.all(
                                width: 1.0,
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "+ " +
                                  yearsExperience(widget.doctor.startWorkDate) +
                                  " of Exp",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              margin: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1.0, color: Colors.grey[200])),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(width: 1.0, color: Colors.grey[200])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            height: 300,
                            child: ListView.builder(
                                itemCount: sessions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  SessionEvent session = sessions[index];
                                  return _buildSessions(
                                      context, session, index + 1);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
