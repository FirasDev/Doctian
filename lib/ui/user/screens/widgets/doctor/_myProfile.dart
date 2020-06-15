import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'SharedWidgets.dart';
import 'Constant.dart';
import 'SharedManager.dart';
// import 'package:health_care/Screens/AddWeightScreen/AddWeightScreen.dart';
// import 'package:health_care/Screens/DoctorList/DoctorList.dart';
// import 'package:health_care/Screens/GoalSettingsScreen/GoalSettingsScreen.dart';
// import 'package:health_care/Screens/OrderList.dart/OrderList.dart';
// import 'package:health_care/main.dart';

import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/ui/user/MyHomePage.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List profileList = [];

  static Doctor doctorInfo = AppConfig().getConnectedDoctor();

  static User doctorDetails = AppConfig().getMainUser();

  final Color defaultColor = new Color(0xff6e79f9);

  final HttpService httpService = HttpService();

  int totalAppointments = 0;
  int rejectedAppointments = 0;
  int historyCount = 0;
  int upcomingAppointments = 0;
  int waitingAppointments = 0;
  int perscriptionsCount = 0;

  void loadVariables() async {
    totalAppointments = await httpService.getAppointmnetsCount();
    rejectedAppointments = await httpService.getRejectedAppointmnetsCount();
    historyCount = await httpService.getAppointmnetsHistoryCount();
    upcomingAppointments = await httpService.getUpcomingAppointmnetsCount();
    waitingAppointments = await httpService.getWaitingAppointmnetsCount();
    perscriptionsCount = await httpService.getPerscriptionsCount();
  }

  _setUserProfiel() {
    return new Container(
      height: 180,
      // color: Colors.red,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: doctorDetails.avatar.length < 13
                        ? AssetImage(AppImage.doctorProfile)
                        : NetworkImage(doctorDetails.avatar))),
          ),
          SizedBox(
            height: 15,
          ),
          setCommonText(
              doctorInfo.name.capitalize() +
                  " " +
                  doctorInfo.lastName.capitalize(),
              Colors.black,
              18.0,
              FontWeight.w500,
              1),
          setCommonText(
              doctorDetails.email, Colors.grey, 17.0, FontWeight.w400, 1)
        ],
      ),
    );
  }

  _setCommonViewForGoal() {
    return new Container(
      height: MediaQuery.of(context).size.width / 1.5,
      padding: new EdgeInsets.all(15),
      child: new Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5),
        child: new Padding(
            padding: new EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Total Appointments",
                                totalAppointments.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Upcoming Appointments",
                                upcomingAppointments.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Rejected Appopintments", 
                                rejectedAppointments.toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                new Container(
                  height: 2,
                  color: Colors.grey[300],
                ),
                new Expanded(
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Waiting Appointments",
                                waitingAppointments.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Finished Appointments",
                                historyCount.toString()),
                          ),
                        ),
                        new Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        new Expanded(
                          child: new Container(
                            child: _setCommonViewForDescription(
                                "Given Perscriptions",
                                perscriptionsCount.toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _setCommonViewForDescription(String title, String bpm) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            child: setCommonText(
                title, AppColor.themeColor, 18.0, FontWeight.w700, 1),
          ),
          SizedBox(height: 15),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              setCommonText(bpm, Colors.black, 20.0, FontWeight.w500, 1),
              SizedBox(
                width: 3,
              ),
            ],
          )
        ],
      ),
    );
  }

  _setBottomView() {
    return new Container(
      height: profileList.length * 80.0,
      color: Colors.grey[200],
      padding: new EdgeInsets.all(15),
      child: new GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 5.5,
        physics: NeverScrollableScrollPhysics(),
        children: List<Widget>.generate(profileList.length, (index) {
          return new Container(
            height: 70,
            padding: new EdgeInsets.only(top: 5, bottom: 5),
            child: new InkWell(
              onTap: () {
                if (index == 0) {
                  () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    AppConfig.MAIN_USER = null;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()),
                        (Route<dynamic> route) => false);
                  };
                } else if (index == 1) {
                  print("2");
                } else if (index == 2) {
                  print("3");
                } else if (index == 3) {
                  print("4");
                } else {
                  SharedManager.shared.currentIndex = 0;
                  print("5");
                }
              },
              child: new Material(
                elevation: 2.0,
                borderRadius: new BorderRadius.circular(5),
                child: new Padding(
                  padding: new EdgeInsets.only(left: 15, right: 15),
                  child: new Row(
                    children: <Widget>[
                      profileList[index]['icon'],
                      SizedBox(
                        width: 12,
                      ),
                      new Container(
                        height: 30,
                        color: Colors.grey[300],
                        width: 2,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      new Expanded(
                          child: setCommonText(profileList[index]['title'],
                              Colors.grey, 16.0, FontWeight.w500, 1)),
                      SizedBox(
                        width: 12,
                      ),
                      new Icon(Icons.arrow_forward_ios,
                          size: 18, color: AppColor.themeColor),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedManager.shared.isOnboarding = true;
    //loadVariables();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      loadVariables();
    });
    this.profileList = [
      {
        "title": "Logout",
        "icon": Icon(
          Icons.settings_power,
          color: AppColor.themeColor,
          size: 18,
        )
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: new Container(
            color: Colors.grey[200],
            child: new ListView(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: defaultColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _setUserProfiel(),
                _setCommonViewForGoal(),
                _setBottomView()
              ],
            )),
      ),
      routes: {'/UserProfile': (BuildContext context) => MyProfile()},
      theme: SharedManager.shared.getThemeType(),
      supportedLocales: [SharedManager.shared.language],
    );
  }
  // //This is for localization
  // void onLocaleChange(Locale locale) {
  //     setState(() {
  //       _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
  //     });
  //   }
}
