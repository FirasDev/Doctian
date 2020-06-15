import 'package:flutter/material.dart';
import 'dart:convert';
import 'speciality.dart';
import 'speciality_list.dart';
import 'search.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';


class SearchBySpeciality extends StatefulWidget {

  @override
  _SearchBySpecialityState createState() => _SearchBySpecialityState();
}

class _SearchBySpecialityState extends State<SearchBySpeciality> {
  List speciality;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/2.7,
                child: Column(
            children: <Widget>[
              Stack(
            children: <Widget>[
              Container(child: Image.asset("assets/images/top_bar.png",
                scale: 0.9,
                fit: BoxFit.fitWidth,
                ),
                ),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back), 
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                        color: Colors.white),
                      Text("Doctors",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                    ),
                    ],
                  ),
                  left: 10.0,
                  bottom: MediaQuery.of(context).size.height/10,
                  ),
                  Positioned(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 50.0,right: 50.0),
                        child: IconButton(
                        icon: Icon(Icons.search), 
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Searching())),
                        color: Colors.white),
                      )
                    ],
                  ),
                  left: 5.0,
                  right: 5.0,
                  top: MediaQuery.of(context).size.height/5,
                  )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height/13,),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
                        child: Text("Specialties",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins-Medium",
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                        ),
            ),
          ),
            ],
          ),
              ),
              new Expanded(
              child: new FutureBuilder(
                future: DefaultAssetBundle.of(context).loadString('assets/static_data/specialities.json'),
                builder: (context,snapshot){
                  List<Speciality> specialities = parseJson(snapshot.data.toString());
                  return specialities.isNotEmpty ? new SpecialityList(speciality: specialities)
                  : new Center(child: new CircularProgressIndicator());
                },
              ),
              )
            ],
          )
        ),
    );
  }

  List<Speciality> parseJson(String response) {
    if(response==null){
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Speciality>((json) => new Speciality.fromJson(json)).toList();
  }
}