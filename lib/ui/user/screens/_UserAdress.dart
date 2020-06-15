import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyAEDQcY_kTih4fEN6rnyqcKDHM7fIdvzOc";

class BspAddressmapscreen extends StatefulWidget {
  BspAddressmapscreen({this.latitudeFinal, this.longFinal});
  final ValueChanged<double> latitudeFinal;
  final ValueChanged<double> longFinal;
  //BspAddressmapscreen({Key key}) : super(key: key);
  final Key _mapKey = UniqueKey();
  @override
  _BspAddressmapscreenState createState() => _BspAddressmapscreenState();
}

class _BspAddressmapscreenState extends State<BspAddressmapscreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  MapType _currentMapType = MapType.normal;
  double latitude;
  double long;
  static LatLng _initialPosition =
      new LatLng(36.86416316988212, 10.167880542576313);
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, "Hello world");
            }),
        centerTitle: true,
        title: Text("Long Press To Add Marker"),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FlatButton.icon(
              icon: Icon(Icons.arrow_back_ios),
              label: Text('Show Address'),
              textColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: () {
                getUserLocation();
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            //_searchbar(),
            _buildGoogleMap(context),
            _zoomminusfunction(),
            _zoomplusfunction(),
          ],
        ),
      ),
    );
  }

  getUserLocation() async {
    //print("Address Length: ${markers.values.length}");

    markers.values.forEach((value) async {
      // widget.latitudeFinal(value.position.latitude);
      print("Latitude Value : ---> " + value.position.latitude.toString());
      print("Longitude Value : ---> " + value.position.longitude.toString());
      widget.longFinal(value.position.longitude);
      widget.latitudeFinal(value.position.latitude);

      /////////////////////////////
      // From coordinates
      // final coordinates =
      //     new Coordinates(value.position.latitude, value.position.longitude);
      // print("Coordinates: ${coordinates.latitude.toString()}");
      // var addresses = await Geocoder.google(kGoogleApiKey)
      //     .findAddressesFromCoordinates(coordinates);
      // try {
      //   var addresses = await Geocoder.google(kGoogleApiKey)
      //       .findAddressesFromCoordinates(coordinates);

      //   // print("Address: ${addresses.first.addressLine}");

      // } catch (error) {
      //   print("Error GeoCoder : ${error.toString()} ");
      // }
      /////////////////////////////
    });
    Navigator.pop(context);
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.remove, color: Color(0xff008080)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.add, color: Color(0xff008080)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: zoomVal)));
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      latitude = position.latitude;
      long = position.longitude;
    });
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Widget _buildGoogleMap(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.of(markers.values),
            onLongPress: (LatLng latLng) {
              // creating a new MARKER
              final MarkerId markerId = MarkerId('4544');
              final Marker marker = Marker(
                markerId: markerId,
                position: latLng,
              );

              setState(() {
                markers.clear();
                // adding a new marker to map
                markers[markerId] = marker;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  Text(""),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      _onMapTypeButtonPressed();
                    },
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.map),
                  ),
                  Text(""),
                ],
              )),
        )
      ],
    );
  }

  // Widget _searchbar() {
  //   return Positioned(
  //     top: 50.0,
  //     right: 15.0,
  //     left: 15.0,
  //     child: Container(
  //       height: 50.0,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10.0), color: Colors.white),
  //       child: TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Enter Address',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
  //           suffixIcon: IconButton(
  //             icon: Icon(Icons.search),
  //             //onPressed: searchandNavigate,
  //             onPressed: () {},
  //             iconSize: 30.0,
  //           ),
  //         ),
  //         onChanged: (val) {
  //           setState(() {
  //             // searchAddr = val;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
}
