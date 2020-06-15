import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/searchResult.dart';
import 'package:hello_world/ui/user/screens/widgets/_DoctorProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSearchDoc extends StatefulWidget {
  @override
  _HomeSearchDocState createState() => _HomeSearchDocState();
}

class _HomeSearchDocState extends State<HomeSearchDoc> {
  List<SearchResult> _list = [];
  List<SearchResult> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("Token From SP : " + value);
    final response = await http.get(API_URL + "/patient/doctors/", headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $value"
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print("Result : " + jsonResponse.toString());
      setState(() {
        _list = (jsonResponse as List)
            .map((data) => new SearchResult.fromJson(data))
            .toList();
        loading = false;
      });
    }
  }

  TextEditingController searchController = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // || (f.distance < double.parse(text))
    _list.forEach((f) {
      print("------->" + text);
      if (f.doctor.specialty.contains(text) ||
          f.doctor.name.contains(text) ||
          f.doctor.lastName.contains(text)) {
        _search.add(f);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Color.fromRGBO(110, 120, 247, 1),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.account_circle),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return UserHome();
                              }));
                            }),
                        Text(
                          "Welcome, " +
                              AppConfig.MAIN_PATIENT.name.capitalize() +
                              " " +
                              AppConfig.MAIN_PATIENT.lastName.capitalize(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.notifications),
                      color: Colors.white,
                      onPressed: () {}),
                ],
              ),
            ),
          ),
          Container(
            //transform: Matrix4.translationValues(0.0, -30.0, 0.0),
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  controller: searchController,
                  onChanged: onSearch,
                  decoration: InputDecoration(
                      hintText: "Search", border: InputBorder.none),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      searchController.clear();
                      onSearch('');
                    }),
              ),
            ),
          ),
          loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: _search.length != 0 || searchController.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _search.length,
                          itemBuilder: (context, i) {
                            final b = _search[i];
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200])),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    IMG_SERVER +
                                                        b.doctor.owner.avatar)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  b.doctor.name.capitalize() +
                                                      " " +
                                                      b.doctor.lastName
                                                          .capitalize(),
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              Text(
                                                  b.doctor.specialty
                                                      .capitalize(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                  b.distance.toString() + " KM",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w300,
                                                  ))),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: _list.length,
                          itemBuilder: (context, i) {
                            final a = _list[i];
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200])),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: InkWell(
                                            onTap: () {
                                              AppConfig.SELECTED_DOCTOR =
                                                  a.doctor;
                                              print('Doctor : ' +
                                                  a.doctor.toString());
                                              Key _mapKey = UniqueKey();
                                              print(_mapKey.toString());
                                              Navigator.push(context,
                                                  new MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return DoctorProfile(
                                                  doctor: a.doctor,
                                                  key: _mapKey,
                                                );
                                              }));
                                            },
                                            child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    IMG_SERVER +
                                                        a.doctor.owner.avatar)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  print('Tapped');
                                                  AppConfig.SELECTED_DOCTOR =
                                                      a.doctor;
                                                  print('Doctor : ' +
                                                      a.doctor.toString());
                                                  Key _mapKey = UniqueKey();
                                                  print(_mapKey.toString());
                                                  Navigator.push(context,
                                                      new MaterialPageRoute(
                                                          builder: (BuildContext
                                                              context) {
                                                    return DoctorProfile(
                                                      doctor: a.doctor,
                                                      key: _mapKey,
                                                    );
                                                  }));
                                                },
                                                child: Text(
                                                    a.doctor.name.capitalize() +
                                                        " " +
                                                        a.doctor.lastName
                                                            .capitalize(),
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontFamily: 'Raleway',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ),
                                              Text(
                                                  a.doctor.specialty
                                                      .capitalize(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey)),
                                          child: Center(
                                              child: Text(
                                                  a.distance.toString() + " KM",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.w300,
                                                  ))),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                )
        ],
      ),
    );
  }
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;
  final Widget child;

  ClipOvalShadow({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRect(child: child, clipper: this.clipper),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;

  _ClipOvalShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(0, 0));
    canvas.drawOval(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
