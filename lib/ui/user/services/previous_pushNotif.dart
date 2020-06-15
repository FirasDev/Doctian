// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:hello_world/ui/user/models/message.dart';
// import 'dart:io';

// import 'package:hello_world/ui/user/screens/_Home_screen.dart';



// class PushNotificationService extends StatefulWidget{
//   final FirebaseMessaging _fcm = FirebaseMessaging();

//   final List<Message> messages = [];


//   Future myBackgroundMessageHandler(Map<String, dynamic> message) async{
//     print(message);
//     }

//   Future initialise() async {
//     if (Platform.isIOS) {
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     }

//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
        
//       },
//       //onBackgroundMessage: myBackgroundMessageHandler,
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//       },
//     );
//     _fcm.requestNotificationPermissions(
//       const IosNotificationSettings(sound: true, badge: true, alert: true)
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Stack(
//                           children: <Widget>[
//                             new IconButton(
//                             icon: Icon(Icons.notifications),
//                             color: Colors.white, onPressed: () {
//                                 setState(() {
//                                   notificationCounter = 0;
//                                 });
//                                 }),
//                               notificationCounter != 0 ? new Positioned(
//                                   right: 11,
//                                   top: 11,
//                                   child: new Container(
//                                     padding: EdgeInsets.all(2),
//                                     decoration: new BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     constraints: BoxConstraints(
//                                     minWidth: 14,
//                                     minHeight: 14,
//                                     ),
//                                     child: Text(
//                                     '$notificationCounter',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 8,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                               ) : new Positioned(
//                               right: 11,
//                               top: 11,
//                               child: new Container(
//                                 padding: EdgeInsets.all(2),
//                                 constraints: BoxConstraints(
//                                   minWidth: 14,
//                                   minHeight: 14,
//                                 )
//                               ),
//                             )
//                           ],
//                         );
//   }

//   Widget buildMessage(Message message) => ListTile(
//     title: Text(message.title),
//     subtitle: Text(message.body),
//   );
// }