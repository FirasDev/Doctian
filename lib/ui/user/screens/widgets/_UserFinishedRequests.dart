import 'dart:developer';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/DrugRequest.dart';
import 'package:hello_world/ui/user/models/medicamentResponse.dart';
import 'package:hello_world/ui/user/models/perscription.dart';
import 'package:hello_world/ui/user/screens/_HomeAnalyse.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserPerscriptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

import '../_HomePrescription.dart';
import '_Dialogs.dart';
import '_UserRequests.dart';

class UserFinishedRequests extends StatefulWidget {
  @override
  _UserRequestsState createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserFinishedRequests> {
  Dialogs dialog = new Dialogs();
 
  final String pendingpostsURL = API_URL+"/Closeddrugreqs/"+AppConfig.MAIN_PATIENT.id;
         

 


  Future<List<MedicamentResponse>> getPendings(id) async {
    final String requestURL = API_URL+"/DrugResponse/"+id;
    Response res = await get(requestURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
    
      List<MedicamentResponse> posts = body
          .map(
            (dynamic item) => MedicamentResponse.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  Future<List<DrugRequest>> getPending() async {
    Response res = await get(pendingpostsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
    
      List<DrugRequest> posts = body
          .map(
            (dynamic item) => DrugRequest.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
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
                              onPressed: () {}),
                          Text(
                            "Welcome, "+ AppConfig.MAIN_PATIENT.name +" " +AppConfig.MAIN_PATIENT.lastName,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //FlatButton(onPressed: () {}, child: Text("Notes")),
                //FlatButton(onPressed: () {}, child: Text("Prescription")),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOvalShadow(
                          shadow: Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6,
                          ),
                          clipper: CustomClipperOval(),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                        'assets/images/btn_ic_doc.png')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) => HomeNotes()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Doctor")
                      ],
                    )),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOvalShadow(
                          shadow: Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6,
                          ),
                          clipper: CustomClipperOval(),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: Container(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                        'assets/images/btn_ic_med.png')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            HomePrescription()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Medicines")
                      ],
                    )),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOvalShadow(
                          shadow: Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6,
                          ),
                          clipper: CustomClipperOval(),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                        'assets/images/btn_ic_diag.png')),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            HomeAnalyse()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Digonostic")
                      ],
                    )),
              ],
            ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Closed Drugs Requests',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),





          





            FutureBuilder(
        
        future: getPending(),
        
        builder: (BuildContext context, AsyncSnapshot<List<DrugRequest>> snapshot) {
          if (snapshot.hasData) {
             if (snapshot.data.isNotEmpty) {
            List<DrugRequest> posts = snapshot.data;
            
            return ListView(
              shrinkWrap: true,
              children: posts
                  .map(
                    (DrugRequest post) => ListTile(
                      
                 
                      leading: Image.asset('assets/images/'+post.image+'.png',height: 50,
    width: 50,),
                      title: Text(post.drug,style: new TextStyle(color:Colors.blueAccent,fontSize:14.50),),
                      subtitle: Text(post.city,style: new TextStyle(fontSize:15.0),),
                      trailing: Icon(
      Icons.done,
      size: 30.0,
    ),
                   onTap: () => {
                     
                      showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return StatefulBuilder(
          builder: (context, setState) {
                  return AlertDialog(
            backgroundColor: Color.fromRGBO(110, 120, 247, 1), 
            
            title: new Text("        Pharmacy details",style: new TextStyle(color:Colors.white,fontSize:20),),
            content: Container(
            
              child: FutureBuilder(
                
        future: getPendings(post.response) ,
        builder: (BuildContext context, AsyncSnapshot<List<MedicamentResponse>> snapshot) {
          if (snapshot.hasData) {
              
              List<MedicamentResponse> posts = snapshot.data;
              
              return Container(
                   
                    height:180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Name: "+posts.single.name+"\n\nAddress: "+posts.single.address+"\n\nDistance: "+posts.single.distance.toString()+" Km\n",style: new TextStyle(color:Colors.white,fontSize:14.50),),
                        IconButton(
                        icon:Icon(Icons.directions),
                          iconSize: 50,
                            color:Colors.white,
                             onPressed: (){MapsLauncher.launchQuery(posts.single.address);},
                         
  
),
                      ]));
              
//               ListView(
//                 children: posts
//                     .map(
//                       (MedicamentResponse res) => ListTile(
//                         title: Text("Name: \n"+res.name+"\n\n\nAddress: \n"+res.address+"\n\n\nDistance: \n"+res.distance.toString()+" km\n\n\n ",style: new TextStyle(color:Colors.white,fontSize:25),),
//                         subtitle: IconButton(
//                           icon: Icon(Icons.directions),
//                           iconSize: 50,
//                             color:Colors.white,
//                              onPressed: (){MapsLauncher.launchQuery(res.address);},
                         
  
// ),
//                       ),
//                     )
//                     .toList(),
//               );
          } else {
             return Center(child: CircularProgressIndicator());
          }
        },
      ),
     
            ),
           
          );
          }
        );
      },
    )
                   },
                      
                    ),
                  )
                  .toList(),
            );
         }else{
            return Text("\n\n\n\nNo closed drugs requests found",style: new TextStyle(fontSize:20.0),);
         } } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      
        Text(""),
        Text(""),
        Text(""),
        Text(""),
        Text(""),

Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //FlatButton(onPressed: () {}, child: Text("Notes")),
                //FlatButton(onPressed: () {}, child: Text("Prescription")),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOvalShadow(
                          shadow: Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6,
                          ),
                          clipper: CustomClipperOval(),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.done,
                                    color: Colors.blue,
      size: 30.0,)), onTap: () {
                                  
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Closed")
                      ],
                    )),
                Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOvalShadow(
                          shadow: Shadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6,
                          ),
                          clipper: CustomClipperOval(),
                          child: ClipOval(
                            child: Material(
                              color: Colors.white, // button color
                              child: InkWell(
                                splashColor: Colors.red, // inkwell color
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.history,
                                    color: Colors.blue,
      size: 30.0,)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder: (_, a1, a2) =>
                                            UserRequests()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Pending")
                      ],
                    )),
               
              ],
            ),

            
          ],
        ),
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
