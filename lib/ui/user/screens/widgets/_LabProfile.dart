import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/laboratory.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:hello_world/ui/user/screens/widgets/lap_clipper.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class LabProfile extends StatefulWidget {
  final Laboratory laboratory;
  LabProfile({Key key, @required this.laboratory}) : super(key: key);
  @override
  _LabProfileState createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
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

  @override
  void initState() {
    _initialPosition = new LatLng(
        widget.laboratory.owner.latitude, widget.laboratory.owner.longitude);
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId("Laboratory Location"),
        draggable: false,
        position: LatLng(widget.laboratory.owner.latitude,
            widget.laboratory.owner.longitude)));
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
          ),
        ),
      ],
    );
  }

  Widget getAddress(Laboratory lab) {
    if (lab.owner.address.contains(lab.owner.zipCode)) {
      return Container(
        width: 300,
        child: Text(
          widget.laboratory.owner.address,
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
          widget.laboratory.owner.address +
              ", " +
              widget.laboratory.owner.city +
              ", Zip : " +
              widget.laboratory.owner.zipCode,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: LapClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      color: Color.fromRGBO(110, 120, 247, 1),
                    ),
                    child: Image(
                        height: 200,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        image: NetworkImage(
                            IMG_SERVER + widget.laboratory.coverPicture)),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          print('object Back');
                          Navigator.pop(context);
                        }))
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -30.0, 0.0),
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
                          child: Text(
                              widget.laboratory.owner.country.capitalize())),
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
                                backgroundImage: NetworkImage(IMG_SERVER +
                                    widget.laboratory.owner.avatar)),
                            Container(
                                margin: EdgeInsets.only(top: 15),
                                child:
                                    Text(widget.laboratory.name.capitalize())),
                          ],
                        ),
                      ),
                      Container(
                          //width: 100,
                          margin: EdgeInsets.all(20),
                          child:
                              Text(widget.laboratory.owner.city.capitalize())),
                    ],
                  ),
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
                    margin: EdgeInsets.only(right: 20, left: 20),
                    decoration: BoxDecoration(
                        //color: Color.fromRGBO(49, 39, 79, 1),
                        border: Border(
                      // top: BorderSide(
                      //    width: 1.0, color: Colors.grey[200]),
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
                                bureauStatus(widget.laboratory.dispoHourStart,
                                    widget.laboratory.dispoHourEnd),
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
                                workTime(widget.laboratory.dispoHourStart,
                                    widget.laboratory.dispoHourEnd),
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
                                      widget.laboratory.workDays);
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
                            child: getAddress(widget.laboratory),
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
                        border:
                            Border.all(width: 1.0, color: Colors.grey[200])),
                    child: _buildGoogleMap(context),
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
