import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hello_world/ui/user/MyHomePage.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/screens/_HomeAppointment.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/_HomeSearch.dart';
import 'package:hello_world/ui/user/screens/_Home_search.dart';
import 'package:hello_world/ui/user/screens/widgets/PharmacyMap.dart';
import 'package:hello_world/ui/user/screens/widgets/_EditPatientProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/_EditUserAccount.dart';
import 'package:hello_world/ui/user/screens/widgets/_Edit_Avatar.dart';
import 'package:hello_world/ui/user/screens/widgets/_UploadAvatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int selectposition = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 290,
                margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(110, 120, 247, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.settings),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, a1, a2) =>
                                          EditUserAccount(
                                            role: AppConfig.MAIN_USER.role,
                                          )),
                                );
                              }),
                          Container(
                            width: 125.0,
                            padding: EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.power_settings_new),
                                    color: Colors.white,
                                    onPressed: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences
                                              .getInstance();
                                      sharedPreferences.clear();
                                      AppConfig.MAIN_USER = null;
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext
                                                              context) =>
                                                          MyHomePage()),
                                              (Route<dynamic> route) =>
                                                  false);
                                    }),
                                // IconButton(
                                //     icon: Icon(Icons.settings),
                                //     color: Colors.white,
                                //     onPressed: () {})
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Padding(padding: EdgeInsets.all(10)),
                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EditAvatar();
                          }));
                        },
                        child: CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(
                                IMG_SERVER + AppConfig.MAIN_USER.avatar)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                                AppConfig.MAIN_PATIENT.name.capitalize() +
                                    " " +
                                    AppConfig.MAIN_PATIENT.lastName
                                        .capitalize(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                )),
                            Padding(padding: EdgeInsets.all(5)),
                            SizedBox(
                                width: 200.0,
                                height: 33,
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (_, a1, a2) =>
                                                EditPatientProfile()),
                                      );
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.white)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 5)),
                                        Text("Edit My Profil",
                                            style: TextStyle(
                                                color: Colors.white))
                                      ],
                                    )))
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 385,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 5, right: 5),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300,
                      child: ListView(
                        children: <Widget>[
                          _buildButtonItem(Icons.assessment,
                              "Medical records", HomeNotes()),
                          _buildButtonItem(Icons.arrow_downward, "Doctors",
                              HomeSearchDoc()),
                          _buildButtonItem(
                              Icons.art_track, "Pharmacy", PharmacySearch()),
                          _buildButtonItem(Icons.calendar_today,
                              "Appointments", HomeAppointment()),
                          // _buildButtonItem(Icons.credit_card,
                          //     "Payments History", HomeNotes()),
                          _buildButtonItem(
                              Icons.vpn_key, "My Key", HomeNotes()),
                        ],
                      ),
                    ))
              ],
            ),
          )

          // Padding(
          //   padding: EdgeInsets.only(top: 15, left: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       IconButton(
          //           icon: Icon(Icons.arrow_back_ios),
          //           color: Colors.white,
          //           onPressed: () {}),
          //       Container(
          //         width: 125.0,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             IconButton(
          //                 icon: Icon(Icons.filter_list),
          //                 color: Colors.white,
          //                 onPressed: () {}
          //                 ),
          //             IconButton(
          //                 icon: Icon(Icons.menu),
          //                 color: Colors.white,
          //                 onPressed: () {}
          //                 )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),

      // bottomNavigationBar: SnakeNavigationBar(
      //   style: SnakeBarStyle.pinned,
      //   currentIndex: selectposition,
      //   onPositionChanged: (index) => setState(() => selectposition = index),
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.chat), title: Text('tickets')),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), title: Text('search'))
      //   ],
      // ),

      // bottomNavigationBar: SnakeNavigationBar(
      //   backgroundColor: Color(0xff353b48),
      //   style: SnakeBarStyle.pinned,
      //   currentIndex: selectposition,
      //   padding: EdgeInsets.all(3),
      //   //onTap:(index)=>setState(()=>selectposition = index),
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(icon: Icon(Icons.home)),
      //   ],
      // ),
    );
  }

  Widget _buildButtonItem(IconData icon, String title, route) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          //Navigator.of(context).push(route);

          // Navigator.push(context,
          //     new MaterialPageRoute(builder: (BuildContext context) {
          //   return route;
          // }));

          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(pageBuilder: (_, a1, a2) => route),
              ModalRoute.withName("/Home"));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(196, 139, 198, 0.3),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                  tag: icon.toString(),
                  child: IconButton(
                      icon: Icon(
                        icon,
                        color: Color.fromRGBO(110, 120, 247, 1),
                        size: 30,
                      ),
                      onPressed: () {})),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Poppins',
                    )),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(110, 120, 247, 1),
                    size: 16,
                  ),
                  color: Colors.black,
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

//  bottomNavigationBar: SnakeNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('tickets')),
//           BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
//           BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('search'))
//         ],
//       ),

// new Column(
//         children: <Widget>[
//           new Container(
//             width: MediaQuery.of(context).size.width,
//             height: 300,
//             margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               color: Color.fromRGBO(110, 120, 247, 1),
//             ),
//             child: new Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 new Padding(padding: EdgeInsets.all(30)),
//                 new CircleAvatar(
//                     radius: 60,
//                     backgroundImage:
//                         NetworkImage('https://via.placeholder.com/140x100')),
//                 new Padding(padding: EdgeInsets.all(5)),
//                 new Text("Jitendra Raut"),
//                 new Text("+91 97306270877"),
//                 new Padding(padding: EdgeInsets.all(10)),
//                 new SizedBox(
//                     width: 200.0,
//                     height: 33,
//                     child: new FlatButton(
//                         onPressed: () {
//                           /*...*/
//                         },
//                         shape: RoundedRectangleBorder(
//                             borderRadius: new BorderRadius.circular(18.0),
//                             side: BorderSide(color: Colors.white)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(
//                               Icons.account_circle,
//                               color: Colors.white,
//                             ),
//                             Padding(padding: EdgeInsets.only(right: 5)),
//                             Text("Edit My Profil",
//                                 style: TextStyle(color: Colors.white))
//                           ],
//                         )))
//               ],
//             ),
//           ),
//           new Text("Jitendra Raut"),
//           new ListView.builder(
//             itemCount: europeanCountries.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(europeanCountries[index]),
//               );
//             },
//           )
//         ],
//       )
