import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/data/error.dart';
import 'package:hello_world/ui/user/data/place_response.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/data/result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PharmacySearch extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<PharmacySearch> {
  _MapState();
  Completer<GoogleMapController> controller1;

  static const String _API_KEY = 'AIzaSyBYEktavYCRo29HIGAgAOqsjzeMDtACm0Y';
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  Error error;

  List<Result> places;
  TextEditingController controller = new TextEditingController();
  bool searching = true;

  double latitude;
  double long;
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;

  bool loading = true;

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
      latitude = position.latitude;
      long = position.longitude;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: "Target", snippet: "This is my destination", onTap: () {}),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  void searchNearby(double latitude, double longitude) async {
    setState(() {
      //  _markers.clear();
    });
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=pharmacy';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data) {
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          _markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }

  Widget mapButton(Function function, Icon icon, Color color) {
    return RawMaterialButton(
      onPressed: function,
      child: icon,
      shape: new CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(7.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (_, a1, a2) => UserHome()),
                  ModalRoute.withName("/Home"));
            },
            child: Icon(
              Icons.arrow_back_ios, // add custom icons also
              size: 35,
            ),
          )
        ],
        title: Text("       Pharmacy search"),
      ),
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(children: <Widget>[
                GoogleMap(
                  markers: _markers,
                  mapType: _currentMapType,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.4746,
                  ),
                  onMapCreated: _onMapCreated,
                  zoomGesturesEnabled: true,
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: () {
                              _onAddMarkerButtonPressed();
                            },
                            child: Icon(Icons.add_location),
                            backgroundColor: Colors.blue,
                          ),
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
                          FloatingActionButton(
                            heroTag: "btn4",
                            onPressed: () {
                              searchNearby(latitude, long);
                            },
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.local_pharmacy),
                          ),
                        ],
                      )),
                )
              ]),
            ),
    );
  }
}
