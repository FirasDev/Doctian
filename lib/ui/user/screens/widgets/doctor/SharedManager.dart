
import 'dart:ui';

import 'package:flutter/material.dart';
import 'Constant.dart';
// import 'package:health_care/Screens/TabBarScreens/Tabbar/Tabbar.dart';
import 'package:hello_world/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  // bool isRTL = true;
  bool isRTL = false;
  var direction = TextDirection.ltr;
  var count = 2;
  bool isOnboarding = false;
  int currentIndex = 0;

  var language =   Locale("en", "");
  // var language =   Locale("es", "");
  // var language =   Locale("ar", "");
  // var language =   Locale("fr", "");

setNavigation(BuildContext context, dynamic viewScreen){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>viewScreen()));
}

  storeBoolValueLocally(bool value,String key)async{
    final prefs = await SharedPreferences.getInstance();
          await prefs.setBool(key, value);
  }

  dynamic retriveStoredValue(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }


String themeType = 'light';
ThemeData getThemeType(){
    return new ThemeData(
      brightness: _getBrightness(),
    );
}

Brightness _getBrightness(){
  if(themeType == "dark"){
     return Brightness.dark;
  }
  else{
    return Brightness.light;
  }
}


setDrawer(BuildContext context,String name,String email){
          return new Drawer(
            child: new Container(
              color: Colors.white,
              child: ListView(
                  padding: new EdgeInsets.all(0.0),
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                          accountName: new Text(name,
                           textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                              fontSize: 18,
                              color: Colors.black
                            )
                          ),
                          accountEmail: new Text(email,
                           textDirection: SharedManager.shared.direction,
                            style: new TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            )
                          ),
                          currentAccountPicture: new GestureDetector(
                            onTap: (){
                              },
                              child: new CircleAvatar(
                              backgroundImage: new AssetImage(AppImage.doctorProfile),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                      ),
                    new ListTile(
                      title: new Text(AppTitle.drawerHome,
                      textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.home,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 0;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerDoctors,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.local_hospital,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 1;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerBlogs,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.speaker_group,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 2;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerIndicators,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.grain,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 3;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerProfile,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.person,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 4;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/TabBar'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerLogout,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor
                      )
                      ),
                      leading: new Icon(Icons.power_settings_new,color:AppColor.themeColor),
                      onTap: (){
                        SharedManager.shared.currentIndex = 0;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage())
                        // ,ModalRoute.withName('/MyHomePage'));
                      },
                    ),
                    Divider(color:Colors.grey,),
                    // ExpansionTile(
                    //   title: new Text('Select Theme',
                    //   style: new TextStyle(
                    //     fontSize: 20,
                    //     color: Colors.black
                    //      )
                    //   ),
                    //   initiallyExpanded: false,
                    //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                    //         children: <Widget>[
                    //           new ListTile(
                    //             title: const Text('Dark',style:  TextStyle(
                    //               color: Colors.black,
                    //             ),),
                    //             onTap: () {
                    //               themeType = 'dark';
                    //               SharedManager.shared.currentIndex = 0;
                    //               Navigator.of(context,rootNavigator: true).
                    //               pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                    //               ,ModalRoute.withName('/TabBar'));
                    //             },      
                    //             leading: Icon(Icons.cloud,color:Colors.black),        
                    //           ),
                    //           new ListTile(
                    //             title: const Text('Light',style:  TextStyle(
                    //               color: Colors.grey,
                    //             ),
                    //             ),
                    //             onTap: () {
                    //               themeType = 'light';
                    //               SharedManager.shared.currentIndex = 0;
                    //               Navigator.of(context,rootNavigator: true).
                    //               pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                    //               ,ModalRoute.withName('/TabBar'));
                    //             },              
                    //             leading: Icon(Icons.cloud,color:AppColor.themeColor),
                    //           ),
                    //     ],
                    // ),
                    new ListTile(
                      title: new Text(AppTitle.drawerShare,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color:AppColor.themeColor,
                      )
                      ),
                      leading: new Icon(Icons.share,color:AppColor.themeColor,),
                      onTap: () {
                        SharedManager.shared.currentIndex = 0;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/MyHomePage'));
                      },
                    ),
                    new ListTile(
                      title: new Text(AppTitle.drawerRateUs,
                       textDirection: SharedManager.shared.direction,
                      style: new TextStyle(
                        fontSize: 18,
                        color: AppColor.themeColor,
                      )
                      ),
                      leading: new Icon(Icons.star,color: AppColor.themeColor,),
                      onTap: () {
                        SharedManager.shared.currentIndex = 0;
                        // Navigator.of(context).
                        // pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TabBarScreen())
                        // ,ModalRoute.withName('/MyHomePage'));
                      },
                    ),
                  ],
                ),
               )
              );
  }

}