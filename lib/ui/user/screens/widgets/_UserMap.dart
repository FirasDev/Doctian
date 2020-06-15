// import 'package:flutter/cupertino.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class PharmacySearch extends StatefulWidget {
//   @override
//   _MapState createState() => _MapState();
// }

// class _MapState extends State<PharmacySearch> {
//   _MapState();
//   Completer<GoogleMapController> controller1;
//   static const String _API_KEY = 'AIzaSyAEDQcY_kTih4fEN6rnyqcKDHM7fIdvzOc';

//   bool searching = true;
  
//   double latitude;
//   double long;
//   static LatLng _initialPositions;
//   final Set<Marker> _markers = {};
//   static LatLng _lastMapPosition = _initialPositions;
//   bool loading = true;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     _getUserLocation();
//     super.initState();
//   }

//   void _getUserLocation() async {
//     Position position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     List<Placemark> placemark = await Geolocator()
//         .placemarkFromCoordinates(position.latitude, position.longitude);
//     setState(() {
//       _initialPositions = LatLng(position.latitude, position.longitude);
//       print('${placemark[0].name}');
//       latitude = position.latitude;
//       long = position.longitude;
//     });
//   }

//   _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       controller1.complete(controller);
//     });
//   }

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   _onAddMarkerButtonPressed() {
//     setState(() {
//       _markers.add(Marker(
//           markerId: MarkerId(_lastMapPosition.toString()),
//           position: _lastMapPosition,
//           infoWindow: InfoWindow(
//               title: "Target", snippet: "This is my destination", onTap: () {}),
//           onTap: () {},
//           icon: BitmapDescriptor.defaultMarker));
//     });
//   }

//   // Widget mapButton(Function function, Icon icon, Color color) {
//   //   return RawMaterialButton(
//   //     onPressed: function,
//   //     child: icon,
//   //     shape: new CircleBorder(),
//   //     elevation: 2.0,
//   //     fillColor: color,
//   //     padding: const EdgeInsets.all(7.0),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         title: Text("       Pharmacy search"),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => HomePage()),
//                   );
//                 },
//                 child: Icon(
//                   Icons.list,
//                   size: 26.0,
//                 ),
//               )),
//         ],
//       ),
//       body: _initialPosition == null
//           ? Container(
//               child: Center(
//                 child: Text(
//                   'loading map..',
//                   style: TextStyle(
//                       fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
//                 ),
//               ),
//             )
//           : Container(
//               child: Stack(children: <Widget>[
//                 GoogleMap(
//                   markers: _markers,
//                   mapType: _currentMapType,
//                   initialCameraPosition: CameraPosition(
//                     target: _initialPosition,
//                     zoom: 14.4746,
//                   ),
//                   onMapCreated: _onMapCreated,
//                   zoomGesturesEnabled: true,
//                   onCameraMove: _onCameraMove,
//                   myLocationEnabled: true,
//                   compassEnabled: true,
//                   myLocationButtonEnabled: false,
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                       margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
//                       child: Column(
//                         children: <Widget>[
//                           FloatingActionButton(
//                             heroTag: "btn1",
//                             onPressed: () {
//                               _onAddMarkerButtonPressed();
//                             },
//                             child: Icon(Icons.add_location),
//                             backgroundColor: Colors.blue,
//                           ),
//                           Text(""),
//                           FloatingActionButton(
//                             heroTag: "btn2",
//                             onPressed: () {
//                               _onMapTypeButtonPressed();
//                             },
//                             backgroundColor: Colors.blue,
//                             child: Icon(Icons.map),
//                           ),
//                           Text(""),
//                         ],
//                       )),
//                 )
//               ]),
//             ),
//     );
//   }
// }
