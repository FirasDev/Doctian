import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/appointment.dart';
import 'package:hello_world/ui/user/screens/_HomeAppointment.dart';
import 'package:hello_world/ui/user/screens/_HomeAppointmentRequest.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';

class UserAppointment extends StatefulWidget {
  final List<Appointment> appointments;
  UserAppointment({Key key, @required this.appointments}) : super(key: key);
  @override
  _UserAppointmentState createState() => _UserAppointmentState();
}

class _UserAppointmentState extends State<UserAppointment> {
  Dialogs dialog = new Dialogs();
  _buildAppointment(BuildContext context, Appointment appointment) {
    return Container(
      margin: EdgeInsets.all(10.0),
      //height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: Colors.grey[200])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          IMG_SERVER + appointment.doctor.owner.avatar)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          appointment.doctor.name.capitalize() +
                              " " +
                              appointment.doctor.lastName.capitalize(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(appointment.doctor.specialty.capitalize(),
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: getStatusColor(appointment.appointmentStatus),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1.0, color: Colors.blue[200])),
                  child: Icon(getStatusIcon(appointment.appointmentStatus)),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 30, left: 30),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 0.5, color: Colors.grey[300])),
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Text(
                  AppConfig.dateFormatAppointment(appointment.appointmentDate),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 0.5, color: Colors.grey[300])),
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(appointment.detailsProvidedByPatient,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      )),
                  color: Color.fromRGBO(110, 120, 247, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  onPressed: () {
                    dialog.deleteAppointement(context, appointment.id);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Appointments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'Poppins',
            )),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: RaisedButton(
                child: Text('Upcoming',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    )),
                color: Color.fromRGBO(110, 120, 247, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                onPressed: () {
                  // dialog.information(context, "title", "description");
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, a1, a2) => HomeAppointment()),
                      ModalRoute.withName("/Home"));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: RaisedButton(
                child: Text('History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    )),
                color: Color.fromRGBO(110, 120, 247, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                onPressed: () {
                  // dialog.information(context, "title", "description");
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, a1, a2) => HomeAppointmentRequest()),
                      ModalRoute.withName("/Home"));
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        (widget.appointments.length != 0)
            ? Container(
                height: 400,
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                //color: Colors.blue,
                child: ListView.builder(
                    itemCount: widget.appointments.length,
                    itemBuilder: (BuildContext context, int index) {
                      Appointment appointment = widget.appointments[index];
                      return _buildAppointment(context, appointment);
                    }),
              )
            : Container(
                margin: EdgeInsets.all(10.0),
                //height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1.0, color: Colors.grey[200])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text("No Appointment To Load",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ],
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
