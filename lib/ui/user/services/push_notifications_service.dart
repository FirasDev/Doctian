import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/models/message.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_notificationList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotificationService extends StatefulWidget {
  @override
  _PushNotificationServiceState createState() =>
      _PushNotificationServiceState();

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static List<Message> messages = [];
  static int notifCounter = messages.length;
  static String deviceToken = "";

  

  void initialise() {
    getDeviceToken();
    configureCallbacks();
  }

  void configureCallbacks() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        messages.add(
            Message(title: notification['title'], body: notification['body']));
        notifCounter = messages.length;
        
        print(notifCounter.toString());
        print("notifs =" + notifCounter.toString());
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void getDeviceToken() async {
  deviceToken = await _firebaseMessaging.getToken();
  print("token = "+deviceToken);
}

}



class _PushNotificationServiceState extends State<PushNotificationService> {
  int counter = PushNotificationService.notifCounter;
  List<Message> myMessages = [];

  Future myBackgroundMessageHandler(Map<String, dynamic> message) async {
    print(message);
  }

  @override
  void initState() {
    super.initState();
    myMessages = PushNotificationService.messages;
    refreshBell();
  }

   void refreshBell(){
   if (counter > 0){
     setState(() {
      });
   }
 }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {
              setState(() {
                //myMessages.clear();
              });
              Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            }),
        counter != 0
            ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    )),
              )
      ],
    );
  }
}
