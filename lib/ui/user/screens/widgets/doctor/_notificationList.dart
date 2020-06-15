import 'package:flutter/material.dart';
import 'SharedWidgets.dart';
import 'Constant.dart';
import 'SharedManager.dart';
import 'package:hello_world/ui/user/models/message.dart';
import 'package:hello_world/ui/user/services/push_notifications_service.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();

  static List<Message> notifMessages = PushNotificationService.messages;
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var messages = NotificationsScreen.notifMessages;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: new ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _setCommonWidgetsForNotificationMessage(
                  messages[index].title,
                  messages[index].body,
                  "1 mins ago",
                  context);
              //_setCommonWidgetsForNotification("It's time to take medical", "3 mins ago",Icon(Icons.link),context);
            },
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(AppTitle.notification, Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10.0,top: 20.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        PushNotificationService.messages.clear();
                      });
                    },
                    child: Text(
                      "Clear all",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ))),
          ],
        ),
      ),
      theme: SharedManager.shared.getThemeType(),
    );
  }
}

_setCommonWidgetsForNotification(
    String title, String time, Icon icon, BuildContext context) {
  return new Container(
    height: 100,
    padding: new EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    child: new Material(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(5),
      elevation: 2.0,
      child: new Padding(
        padding: new EdgeInsets.only(left: 15, right: 15),
        child: new Row(
          children: <Widget>[
            new Icon(Icons.insert_link),
            SizedBox(
              width: 8,
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                setCommonText(title, Colors.black, 18.0, FontWeight.w500, 1),
                SizedBox(
                  height: 5,
                ),
                setCommonText(time, Colors.grey, 16.0, FontWeight.w500, 1),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

_setCommonWidgetsForNotificationMessage(
    String title, String text, String time, BuildContext context) {
  return new Container(
    height: 170,
    padding: new EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    child: new Material(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(5),
      elevation: 2.0,
      child: new Padding(
        padding: new EdgeInsets.only(left: 15, right: 15),
        child: new Row(
          children: <Widget>[
            new Container(
              height: 50,
              width: 50,
              // color: Colors.red,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(AppImage.doctorList),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 8,
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(title, Colors.black, 20.0, FontWeight.w500, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText(text, Colors.grey, 16.0, FontWeight.w500, 2),
                  SizedBox(
                    height: 8,
                  ),
                  setCommonText(time, Colors.grey, 12.0, FontWeight.w500, 1),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
