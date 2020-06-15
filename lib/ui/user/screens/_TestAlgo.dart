import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/eventDay.dart';
import 'package:hello_world/ui/user/models/notes.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestUnit extends StatefulWidget {
  TestUnit({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TestUnitState createState() => new _TestUnitState();
}

class _TestUnitState extends State<TestUnit> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
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
    var response = await http.get(
        API_URL + "/patient/doctor/days/5e81d3a66c42b322b8324b15",
        headers: {
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

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    // _markedDateMap.add(
    //     new DateTime(2019, 2, 25),
    //     new Event(
    //       date: new DateTime(2019, 2, 25),
    //       title: 'Event 5',
    //       icon: _eventIcon,
    //     ));

    // _markedDateMap.add(
    //     new DateTime(2019, 2, 10),
    //     new Event(
    //       date: new DateTime(2019, 2, 10),
    //       title: 'Event 4',
    //       icon: _eventIcon,
    //     ));

    // _markedDateMap.addAll(new DateTime(2019, 2, 11), [
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 1',
    //     icon: _eventIcon,
    //   ),
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 2',
    //     icon: _eventIcon,
    //   ),
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 3',
    //     icon: _eventIcon,
    //   ),
    // ]);

    loadEventDays();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        if (events.length > 0) {
          events.forEach((event) {
            if (event.title == "0") {
              print('pressed date $date');
              print('');
            } else {
              print('Day Blocked');
            }
          });
        } else {
          ///
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
        color: Colors.yellow,
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
      todayBorderColor: Colors.green,

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

    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        print('long pressed date $date');
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ), // This trailing comma makes auto-formatting nicer for build methods.
              //custom icon without header
              // Container(
              //   margin: EdgeInsets.only(
              //     top: 30.0,
              //     bottom: 16.0,
              //     left: 16.0,
              //     right: 16.0,
              //   ),
              //   child: new Row(
              //     children: <Widget>[
              //       Expanded(
              //           child: Text(
              //         _currentMonth,
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 24.0,
              //         ),
              //       )),
              //       FlatButton(
              //         child: Text('PREV'),
              //         onPressed: () {
              //           setState(() {
              //             _targetDateTime = DateTime(
              //                 _targetDateTime.year, _targetDateTime.month - 1);
              //             _currentMonth =
              //                 DateFormat.yMMM().format(_targetDateTime);
              //           });
              //         },
              //       ),
              //       FlatButton(
              //         child: Text('NEXT'),
              //         onPressed: () {
              //           setState(() {
              //             _targetDateTime = DateTime(
              //                 _targetDateTime.year, _targetDateTime.month + 1);
              //             _currentMonth =
              //                 DateFormat.yMMM().format(_targetDateTime);
              //           });
              //         },
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: _calendarCarouselNoHeader,
              // ), //
            ],
          ),
        ));
  }
}
