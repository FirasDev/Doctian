import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:hello_world/ui/user/config/config.dart';
import '_DoctorAppointments.dart';

void main() => runApp(DoctorCalendar());

class DoctorCalendar extends StatelessWidget {
  final List<Appointment> apps;
  DoctorCalendar({Key,key, this.apps}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flen Ben Foulen's Calendar",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorCalendarPage(apps: apps,),
    );
  }
}

class DoctorCalendarPage extends StatefulWidget {
  final List<Appointment> apps;
  DoctorCalendarPage({Key,key, this.apps}) : super(key: key);
  @override
  _DoctorCalendarPageState createState() => _DoctorCalendarPageState();
}

class _DoctorCalendarPageState extends State<DoctorCalendarPage> {
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    for (int i = 0; i < widget.apps.length;i++){
      _events[widget.apps[i].appointmentDate] = [widget.apps[i].patient.name.capitalize() + " " + widget.apps[i].patient.lastName.capitalize()];
    }
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
                                  icon: Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorAppointments()));
                                  }),
                              Text(
                                "Flen Ben Foulen's Calendar",
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
          TableCalendar(
              events: _events,
              locale: 'en_US',
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
                showSelectedDayAppointments(context,_selectedEvents);
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            
          Container(
            child: Image.asset(
        "assets/images/staff.png",
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomLeft,
      ),
          )
          ],
        ),
      ),
    );
  }
}

Future<bool> showSelectedDayAppointments(context,_selectedEvents) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 350.0,
                width: 200.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(height: 150.0),
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Colors.teal),
                        ),
                        Positioned(
                            top: 50.0,
                            left: 94.0,
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/chokri_hammouda.png"),
                                      fit: BoxFit.cover)),
                            ))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          _selectedEvents[0],
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    SizedBox(height: 15.0),
                    FlatButton(
                      child: Center(
                        child: Text(
                          'OKAY',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.0,
                              color: Colors.teal),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.transparent
                    )
                  ],
                )));
      });
}

