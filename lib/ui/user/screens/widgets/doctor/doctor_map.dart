// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../data/error.dart';
// import '../data/result.dart';
// import '../data/error.dart';
// import '../data/place_response.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'doctors_list_by_speciality.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DoctorMap extends StatefulWidget {
//   final String passedSpeciality;

//   DoctorMap({Key key, @required this.passedSpeciality}) : super (key:key);

//   @override
//   _DoctorMapState createState() => _DoctorMapState();
// }

// class _DoctorMapState extends State<DoctorMap> {

//   @override
//   Widget build(BuildContext context) {
//     String speciality = widget.passedSpeciality;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MapSample(passedSpeciality: speciality,),
//     );
//   }
// }


// class MapSample extends StatefulWidget {
//   final String passedSpeciality;
//   final String keyword;
//   MapSample({Key key, @required this.passedSpeciality,this.keyword}) : super (key:key);

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//   Position _currentPosition;
//   String _currentAddress;
//   static const String _API_KEY = '{{AIzaSyCHttDwWqfmp9z2uuZT_PHjO8KI43hBoBU}}';
//   static const String baseUrl =
//       "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
//   List<Marker> markers = <Marker>[];
//   bool searching = true;
//   Error error;
//   List<Result> places;

//   @override
//   Widget build(BuildContext context) {
//     String speciality = widget.passedSpeciality;  
//     _getCurrentLocation();
//     print("=============");
//     print(speciality);
//     print(_currentPosition.toString());
//     print("=============");
//     searchNearby(_currentPosition.latitude,_currentPosition.longitude);
//     return new Scaffold(
//       body: Column(
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height/4,
//                 child: Column(
//             children: <Widget>[
//               Stack(
//             children: <Widget>[
//               Container(
//                 child: Image.asset("assets/images/top_bar.png",
//                 scale: 0.9,
//                 fit: BoxFit.fitWidth,
//                 ),
//                 ),
//                 Positioned(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           IconButton(
//                             icon: Icon(Icons.arrow_back), 
//                             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsListBySpeciality(passedSpeciality: speciality))),
//                             color: Colors.white),
//                           Text(_currentAddress == null ? Text("Searching..") : _currentAddress.toString(),
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontFamily: "Poppins-Medium",
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                         ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   left: 5.0,
//                   right: 5.0,
//                   bottom: MediaQuery.of(context).size.height/13,
//                   ),
//             ],
//           ),
//             ],
//           ),
//               ),
//               new Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: new Card(
//                   elevation: 18.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Stack(
//                     children: <Widget>[
//                       GoogleMap(
//                             markers: Set<Marker>.of(markers),
//                             mapType: MapType.normal,
//                             myLocationEnabled: true,
//                             myLocationButtonEnabled: true,
//                             initialCameraPosition: CameraPosition(
//                               target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//                               zoom: 13.0,
//                               ),
//                             onMapCreated: (GoogleMapController controller) {
//                             _controller.complete(controller);
//                             },
//                           ),
//                     ],
//                   ),
//                       ),
//               ),
//               )
//             ],
//           ),
//     );
//       }
//   _getCurrentLocation() {
//     geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });

//       _getAddressFromLatLng();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.locality}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   // 1
// void searchNearby(double latitude, double longitude) async {
//   sleep1();
//   setState(() {
//     //markers.clear(); // 2
//   });
//   // 3
//   String url =
//       '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=doctor';
//   print(url);
//   // 4
//   final response = await http.get(url);
//   // 5
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     _handleResponse(data);
//   } else {
//     throw Exception('An error occurred getting places nearby');
//   }
//   setState(() {
//     searching = false; // 6
//   });
// }

// void _handleResponse(data){
//     // bad api key or otherwise
//       if (data['status'] == "REQUEST_DENIED") {
//         setState(() {
//           error = Error.fromJson(data);
//         });
//         // success
//       } else if (data['status'] == "OK") {
//         setState(() {
//           places = PlaceResponse.parseResults(data['results']);
//           for (int i = 0; i < places.length; i++) {
//            markers.add(
//               Marker(
//                 markerId: MarkerId(places[i].placeId),
//                 position: LatLng(places[i].geometry.location.lat,
//                     places[i].geometry.location.long),
//                 infoWindow: InfoWindow(
//                     title: places[i].name, snippet: places[i].vicinity),
//                 onTap: () {},
//               ),
//             );
//           }
//         });
//       } else {
//         print(data);
//       }
//   }

// Future sleep1() {
//   return new Future.delayed(const Duration(seconds: 3), () => "3");
// }

// }