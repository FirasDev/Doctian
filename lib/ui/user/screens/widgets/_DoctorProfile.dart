import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/screens/_HomeSession.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:intl/intl.dart';

const kGoogleApiKey = "AIzaSyAEDQcY_kTih4fEN6rnyqcKDHM7fIdvzOc";

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;
  DoctorProfile({Key key, @required this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Dialogs dialog = new Dialogs();

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

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  MapType _currentMapType = MapType.normal;
  double latitude;
  double long;
  static LatLng _initialPosition;
  Completer<GoogleMapController> _controller = Completer();
  // creating a new MARKER
  List<Marker> allMarkers = [];

  //Set<Marker> markers = Set();

  @override
  void initState() {
    _initialPosition =
        new LatLng(widget.doctor.owner.latitude, widget.doctor.owner.longitude);
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId("Doctor Location"),
        draggable: false,
        position: LatLng(
            widget.doctor.owner.latitude, widget.doctor.owner.longitude)));
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1.0, color: Colors.grey[200])),
          child: GoogleMap(
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            //markers: Set<Marker>.of(markers),
            markers: Set.from(allMarkers),
            // onLongPress: (LatLng latLng) {
            //   // creating a new MARKER
            //   final MarkerId markerId = MarkerId('4544');
            //   final Marker marker = Marker(
            //     markerId: markerId,
            //     position: latLng,
            //   );

            //   setState(() {
            //     markers.clear();
            //     // adding a new marker to map
            //     markers[markerId] = marker;
            //   });
            // },
          ),
        ),
      ],
    );
  }

  Widget getAddress(Doctor doc) {
    if (doc.owner.address.contains(doc.owner.zipCode)) {
      return Container(
        width: 300,
        child: Text(
          widget.doctor.owner.address,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Color.fromRGBO(110, 120, 247, 1),
          ),
        ),
      );
    } else {
      return Container(
        width: 300,
        child: Text(
          widget.doctor.owner.address +
              ", " +
              widget.doctor.owner.city +
              ", Zip : " +
              widget.doctor.owner.zipCode,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color.fromRGBO(110, 120, 247, 1),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        width: 100,
                        margin: EdgeInsets.all(20),
                        child: Text(widget.doctor.owner.role)),
                    Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(width: 6.0, color: Colors.white)),
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
                        width: 100,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        margin: EdgeInsets.only(left: 20),
                        height: 45,
                        //width: 200,

                        child: Center(
                          child: Text(
                            "Fee : " +
                                widget.doctor.fee.toString() +
                                AppConfig.currencyFormat(),
                            style: TextStyle(
                              color: Color.fromRGBO(110, 120, 247, 1),
                            ),
                          ),
                        ),
                      ),
                      /*
                      Container(
                        //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
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
                            " analysis",
                            style: TextStyle(
                              color: Color.fromRGBO(110, 120, 247, 1),
                            ),
                          ),
                        ),
                      ),
                      */
                      RaisedButton(
                        child: Text('Make Appointement',
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
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return HomeSession(
                              doctor: AppConfig.SELECTED_DOCTOR,
                            );
                          }));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                      //color: Color.fromRGBO(49, 39, 79, 1),
                      border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey[200]),
                    bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: Text(
                              bureauStatus(widget.doctor.dispoHourStart,
                                  widget.doctor.dispoHourEnd),
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: Text(
                              workTime(widget.doctor.dispoHourStart,
                                  widget.doctor.dispoHourEnd),
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                dialog.information(context, "Day of Works",
                                    widget.doctor.workDays);
                              },
                              child: Text(
                                "All Timing",
                                style: TextStyle(
                                  color: Color.fromRGBO(110, 120, 247, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Icon(Icons.pin_drop)),
                      Container(
                        //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        margin: EdgeInsets.only(left: 5),
                        height: 45,
                        child: Center(
                          child:
                              // Text(
                              //   widget.doctor.owner.city +
                              //       ", " +
                              //       widget.doctor.owner.address +
                              //       ", Zip : " +
                              //       widget.doctor.owner.zipCode,
                              //   style: TextStyle(
                              //     color: Color.fromRGBO(110, 120, 247, 1),
                              //   ),
                              // )
                              getAddress(widget.doctor),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1.0, color: Colors.grey[200])),
                  child:
                      _buildGoogleMap(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
