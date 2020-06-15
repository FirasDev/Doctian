import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/eventDay.dart';
import 'package:hello_world/ui/user/screens/_HomeSessionSelect.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSession extends StatefulWidget {
  final Doctor doctor;

  HomeSession({
    Key key,
    @required this.doctor,
  }) : super(key: key);
  @override
  _HomeSessionState createState() => _HomeSessionState();
}

class _HomeSessionState extends State<HomeSession> {
  Dialogs dialog = new Dialogs();
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  static Widget _eventBlocked = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.block,
      color: Colors.redAccent,
    ),
  );

  static Widget _eventAttention = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.error_outline,
      color: Colors.amber,
    ),
  );

  Widget getIcons(int status) {
    if (status == 0) {
      return _eventAttention;
    } else {
      return _eventBlocked;
    }
  }

  List<EventDay> eventDay = [];
  void loadEventDays() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    var jsonResponse = null;
    var response = await http
        .get(API_URL + "/patient/doctor/days/" + widget.doctor.id, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });
    print("APi Response Status : " + response.statusCode.toString());
    print("APi Response : " + response.body.toString());
    jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          eventDay = (jsonResponse as List)
              .map((data) => new EventDay.fromJson(data))
              .toList();
        });
      }
      eventDay.forEach((event) {
        print("${event.status} is Status? ${event.id}");
        _markedDateMap.add(
            new DateFormat("yyyy-MM-dd", "en_US").parse(event.id),
            new Event(
              date: new DateFormat("yyyy-MM-dd", "en_US").parse(event.id),
              title: event.status.toString(),
              icon: getIcons(event.status),
            ));
      });
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  EventList<Event> _markedDateMap = new EventList<Event>();

  CalendarCarousel _calendarCarousel;

  @override
  void initState() {
    loadEventDays();
    super.initState();
  }

  String yearsExperience(DateTime date) {
    if (DateTime.now().year == date.year)
      return "1";
    else
      return (DateTime.now().year - date.year).toString();
  }

  String bureauStatus(DateTime start, DateTime end) {
    if (DateTime.now().hour > start.hour && DateTime.now().hour < end.hour)
      return "Open Now";
    else
      return "Closed Now";
  }

  String workTime(DateTime start, DateTime end) {
    return DateFormat.jm().format(start) + " - " + DateFormat.jm().format(end);
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        if (events.length > 0) {
          events.forEach((event) {
            if (event.title == "0") {
              print('pressed date $date');
              print('');
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (BuildContext context) {
              //   return HomeSessionSelect(
              //     doctor: AppConfig.SELECTED_DOCTOR,
              //     selectedDate: date,
              //   );
              // }));

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeSessionSelect(
                            doctor: AppConfig.SELECTED_DOCTOR,
                            selectedDate: date,
                          )),
                  ModalRoute.withName("/Home"));
            } else {
              print('Day Blocked');
            }
          });
        } else {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return HomeSessionSelect(
              doctor: AppConfig.SELECTED_DOCTOR,
              selectedDate: date,
            );
          }));
          print('Open Day Without Appointements');
        }
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      headerText: _currentMonth,
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 200.0,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: false,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 1)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.blueAccent,

      //
      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
      markedDateIconMargin: 9,
      markedDateIconOffset: 3,
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _currentMonth = DateFormat.yMMM().format(date);
        });
      },
    );

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
                          //width: 100,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child:
                                Icon(Icons.error_outline, color: Colors.amber)),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          margin: EdgeInsets.only(left: 5),
                          height: 45,
                          child: Center(
                            child: Text(
                              "Reserved Day",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(Icons.block, color: Colors.redAccent)),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          margin: EdgeInsets.only(left: 5),
                          height: 45,
                          child: Center(
                            child: Text(
                              "Reserved Day Or Doctor Weekend",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(width: 1.0, color: Colors.grey[200])),
                    child: _calendarCarousel,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text('AI Auto-Select Appointement',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          )),
                      color: Color.fromRGBO(110, 120, 247, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      onPressed: () {
                        // DatePicker.showDateTimePicker(context,
                        //     showTitleActions: true,
                        //     minTime: DateTime.now(),
                        //     maxTime: DateTime(2020, 12, 31, 00, 00),
                        //     onChanged: (date) {
                        //   print('change $date in time zone ' +
                        //       date.timeZoneOffset.inHours.toString());
                        // }, onConfirm: (date) {
                        //   print('confirm $date');
                        //   dialog.appointment(
                        //       context, "Appointment at ", date);
                        // }, locale: LocaleType.en);

                        dialog.createAutoAppointment(context, widget.doctor.id);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
