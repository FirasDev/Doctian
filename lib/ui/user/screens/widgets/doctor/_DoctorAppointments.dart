import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_world/ui/user/data/data.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import '_doctorCalendar.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:intl/intl.dart';
import 'package:hello_world/ui/user/config/config.dart';

class DoctorAppointments extends StatefulWidget {
  
static int appointmentIndex;

  @override
  _DoctorAppointmentsState createState() => _DoctorAppointmentsState();
}
final _random = new Random();
List<String> images = ["male1.png", "female1.png", "male2.png", "female2.png","male3.png", "female3.png",];   

List<String> statusList = ['Accepted', 'Rejected','Pending','Waiting'];

List<String> appointmentTitle = ['Accepted Appoinments','Rejected Appoinments','Pending Appoinments','Waiting Appoinments','All Appoinments'];



String decideUserImage(String gender){  
    return images[_random.nextInt(images.length)];
  }

String decideStatusImage(String status){
  if (status == statusList[0])
  return "Accepted.png";
  else if (status == statusList[1])
  return "Rejected.png";
  else if (status == statusList[2])
  return "Pending.png";
  else 
  return "Waiting.png";
}

Color decideStatusColor(String status){
  if (status == statusList[0])
  return Colors.green;
  else if (status == statusList[1])
  return Colors.red;
  else if (status == statusList[2])
  return Colors.grey;
  else 
  return Colors.white;
}

final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );
final headerTextStyle = baseTextStyle.copyWith(
      color: new Color(Colors.white.value),
      fontSize: 18.0,
      fontWeight: FontWeight.w600
    );
final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 12.0,
      fontWeight: FontWeight.w400
    );
final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0
    );
class _DoctorAppointmentsState extends State<DoctorAppointments> {
  @override
  void initState() { 
    super.initState();
    _appointmentIndex = DoctorAppointments.appointmentIndex;
  }
  int _appointmentIndex = 4;

  Choice _selectedChoice = choices[0];

void _select(Choice choice) {
      setState(() {
        _selectedChoice = choice;
      });
    }
    
  _buildAppointment(BuildContext context, Appointment appointment,DoctorAppointments) {
    return new Container(
                height: 140.0,
                margin: const EdgeInsets.symmetric(
                vertical: 13.0,
                horizontal: 24.0,
                ),
                child: 
                new Stack(
                children: <Widget>[
                Container(
                  child: Container(
      margin: new EdgeInsets.fromLTRB(45.0, 16.0, 1.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(appointment.patient.name.capitalize() + " " + appointment.patient.lastName.capitalize(), style: headerTextStyle),
          new Container(height: 3.0),
          Expanded(
                      child: new Row(
              children: <Widget>[
                new Image.asset("assets/images/message.png", height: 16.0,),
                new Container(width: 5.0),
                Expanded(
                                  child: new Text(appointment.detailsProvidedByPatient, 
                  style: subHeaderTextStyle,maxLines: 1,),
                ),
                PopupMenuButton<Choice>(
                        onSelected: _select,
                        itemBuilder: (BuildContext context) {
                          return choices.map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: GestureDetector(
                                onTap: (){
                                  if (choice.index == 0){
                                    httpService.rejectAppointment(appointment.id);
                                    this.setState(() { });
                                  }
                                  else if (choice.index == 1){
                                    httpService.rescheduleAppointment(appointment.id);
                                    this.setState(() { });
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(choice.icon),
                                    SizedBox(width: 8.0),
                                    Text(choice.title),
                                  ],
                                ),
                              )
                            );
                          }).toList();
                        },
            ),
              ],
            ),
          ),
          Center(
            child: new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 3.0,
              width: MediaQuery.of(context).size.width/2.5,
              color: decideStatusColor(appointment.appointmentStatus)
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                child: Row(
                    children: <Widget>[
                      new Image.asset("assets/images/"+decideStatusImage(appointment.appointmentStatus), height: 16.0),
                      new Container(width: 5.0),
                      new Text(appointment.appointmentStatus, style: regularTextStyle),
                    ]
                  )

              ),
              new Container(
                child: GestureDetector(
                  onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorCalendar(apps: appointments,)));
                      },
                    child: Row(
                      children: <Widget>[
                        new Image.asset("assets/images/Calendar.png", height: 16.0),
                        new Container(width: 5.0),
                        new Text(
                          new DateFormat.MMMMd().format(appointment.appointmentDate)
                          + " at " +
                          DateFormat.Hm().format(appointment.appointmentDate)
                          , style: regularTextStyle),
                      ]
                    ),
                )
              )
            ],
          ),
        ],
      ),
    ),
                  height: 124.0,
                  margin: new EdgeInsets.only(left: 46.0),
                  decoration: new BoxDecoration(
                    color: new Color(0xFF6e78f7),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(  
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: new EdgeInsets.symmetric(
                    vertical: 16.0
                    ),
                    alignment: FractionalOffset.centerLeft,
                    child: new Image(
                    image: new AssetImage("assets/images/"+decideUserImage("eeee"))),
                    height: 92.0,
                    width: 92.0,
                    ),
                ],
                )
                );
  }

  final HttpService httpService = HttpService();

  Future <List<Appointment>> sortAppointments(index){
    if (index == 0)
    return httpService.getAcceptedAppointments();
    else if (index == 1)
    return httpService.getRejectedAppointments();
    else if (index == 2)
    return httpService.getPendingAppointments();
    else if (index == 3)
    return httpService.getWaitingAppointments();
    else 
    return httpService.getAppointments();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child : Container(
      height: MediaQuery.of(context).size.height/1.65,
              child: Column(
        children: <Widget>[
          Text(
            _appointmentIndex == null ? appointmentTitle[4] :
            appointmentTitle[_appointmentIndex],
            style: TextStyle(
              color: Colors.black,
              fontSize: 23.0,
              fontFamily: 'Poppins')
              ),
          SizedBox(height: 10,),
          Expanded(
                child: FutureBuilder(
                future: sortAppointments(_appointmentIndex),
                builder: (BuildContext context, AsyncSnapshot<List<Appointment>> snapshot){
                  if (snapshot.hasData){
                    List<Appointment> appointments  = snapshot.data;
                    return appointments.isEmpty ? 
                        Container(
                        height: 130.0,
                        margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset("assets/images/chokri_hammouda2.png", 
                            height: MediaQuery.of(context).size.height/3),
                            new Container(width: 5.0),
                            new Text("Oops...There doesn't seem to be any patient here.", 
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.normal
                            )),
                          ],
                        )
                        ) :
                    ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    Appointment appointment = appointments[index];
                    return _buildAppointment(context, appointment,appointments);
                  });
                  }
                  return Center(child: CircularProgressIndicator());
                },
                )
            ),
        ],
    ),
      ),
    );
  }
}

Color getStatusColor(String status) {
  if (status == 'Accepted') {
    return Colors.green;
  } else {
    return Colors.red;
  }
}


IconData getStatusIcon(String status) {
  if (status == 'Accepted') {
    return Icons.done;
  } else {
    return Icons.close;
  }
  
}

class Choice {
  const Choice({this.title, this.icon, this.index});

  final String title;
  final IconData icon;
  final int index;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Reject', icon: FontAwesomeIcons.userTimes,index: 0),
  const Choice(title: 'Reschedule', icon: FontAwesomeIcons.calendarTimes,index: 1),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}