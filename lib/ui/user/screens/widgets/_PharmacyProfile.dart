import 'package:flutter/material.dart';

class PharmacyProfile extends StatefulWidget {
  @override
  _PharmacyProfileState createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile> {
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
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1.0, color: Colors.grey[200])),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 100,
                        margin: EdgeInsets.all(20),
                        child: Text("Medenine")),
                    Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(width: 6.0, color: Colors.white)),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/140x100')),
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text("Name")),
                        ],
                      ),
                    ),
                    Container(
                        width: 100,
                        margin: EdgeInsets.all(20),
                        child: Text("City")),
                  ],
                ),
                Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text("Medenine")),
              ],
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1.0, color: Colors.grey[200])),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                      //color: Color.fromRGBO(49, 39, 79, 1),
                      border: Border(
                    // top: BorderSide(
                    //    width: 1.0, color: Colors.grey[200]),
                    bottom: BorderSide(width: 1.0, color: Colors.grey[200]),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: Text(
                              "Closed NOW",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: Text(
                              "08:00 AM - 09:00 PM",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          height: 45,
                          //width: 200,
                          child: Center(
                            child: Text(
                              "All Timing",
                              style: TextStyle(
                                color: Color.fromRGBO(110, 120, 247, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Icon(Icons.pin_drop)),
                      Container(
                        //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        margin: EdgeInsets.only(left: 5),
                        height: 45,
                        child: Center(
                          child: Text(
                            "Fee sqddsqdsq  sqdsqdsqd",
                            style: TextStyle(
                              color: Color.fromRGBO(110, 120, 247, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1.0, color: Colors.grey[200])),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Building92microsoft.jpg/1200px-Building92microsoft.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
