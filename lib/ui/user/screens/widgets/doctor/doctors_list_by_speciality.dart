import 'package:flutter/material.dart';
import 'search_by_specialty.dart';
import 'doctor_map.dart';

class DoctorsListBySpeciality extends StatefulWidget {
  final String passedSpeciality;

  DoctorsListBySpeciality({Key key, @required this.passedSpeciality}) : super (key:key);

  @override
  _DoctorsListBySpecialityState createState() => _DoctorsListBySpecialityState();
}

class _DoctorsListBySpecialityState extends State<DoctorsListBySpeciality> {
  @override
  Widget build(BuildContext context) {
    String speciality = widget.passedSpeciality;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back), 
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBySpeciality())),
                            color: Colors.white),
                          Text(speciality,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins-Medium",
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                        ),
                        ],
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.map), 
                            onPressed: () {},
                            color: Colors.white),
                      )
                    ],
                  ),
                  left: 5.0,
                  right: 5.0,
                  bottom: MediaQuery.of(context).size.height/11,
                  ),
                  Positioned(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 50.0,right: 50.0),
                        child: Text("search bar here"),
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
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Card(

                    ),
                  );
                }
              )
              )
            ],
          )
        ),
    );
  }

}