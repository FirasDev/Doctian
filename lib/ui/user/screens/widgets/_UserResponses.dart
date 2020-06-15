import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/data/data.dart';
import 'package:hello_world/ui/user/models/DrugRequest.dart';
import 'package:hello_world/ui/user/models/medicamentResponse.dart';
import 'package:hello_world/ui/user/screens/_HomeAnalyse.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRequests.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import '../_HomePrescription.dart';


class UserResponse extends StatelessWidget {
  
   final DrugRequest drugreq;

  UserResponse({@required this.drugreq});

  

   

   
  
  Future updateDistance(resId,distance) async {    
  String apiUrl = API_URL+'/drugreps/'+resId+'/'+distance;
  Response response = await put(apiUrl,headers: {
   
  }, body:  {});
  print("Result: ${response.body}");
  return json.decode(response.body);
}
 
  

 Future updateRequest(idres) async {
  String apiUrl = API_URL+'/drugreqs/'+drugreq.id+'/'+idres;
  Response response = await put(apiUrl,headers: {
   
  }, body:  {"state": "Accepted" });
  print("Result: ${response.body}");
  return json.decode(response.body);
}

  Future<List<MedicamentResponse>> getResponses() async {
    final String pendingpostsURL = API_URL+"/Pendingdrugreps/"+drugreq.id;
    
    Response res = await get(pendingpostsURL);
    
    if (res.statusCode == 200) {
      
      List<dynamic> body = jsonDecode(res.body);
      for (var i = 0; i < body.length; i++) {
        Position position = await Geolocator().getCurrentPosition();
        var addresses = await Geocoder.local.findAddressesFromQuery(body[i]['address']);
      var first = addresses.first;
        final double distance = await Geolocator().distanceBetween( position.latitude, position.longitude, first.coordinates.latitude, first.coordinates.longitude);
        var dist = (distance/1000).toStringAsFixed(3);
        
      updateDistance(body[i]['_id'], dist);
  
      }
   
    
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
                'Pharmacy Drugs Responses',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),

        
       


            FutureBuilder(
        
        future: getResponses(),
        
        builder: (BuildContext context, AsyncSnapshot<List<MedicamentResponse>> snapshot) {
          if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            List<MedicamentResponse> posts = snapshot.data;
            
          
            return  ListView(
              shrinkWrap: true,
              children: posts
                  .map(
                    (MedicamentResponse post) => ListTile  (
                    
                 
                      leading: Image.asset('assets/images/pharm.png',height: 50,
    width: 50,),
                      title: Text(post.name,style: new TextStyle(color:Colors.blueAccent,fontSize:14.50),),
                      subtitle: Text(post.address,style: new TextStyle(fontSize:15.0),),
                      trailing: Text(post.distance.toString()+" km",style: new TextStyle(fontSize:15.0),),
                    onTap: () => {

                      showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return FutureBuilder(
          builder: (context, setState) {
                  return AlertDialog(
            title: new Text("Drug request",textAlign: TextAlign.center,style: new TextStyle(fontSize:25.0),),
            content: new Text("Do you want to choose this pharmacy?",textAlign: TextAlign.left,style: new TextStyle(fontSize:19.0),),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                //EdgeInsets.all(MediaQuery.of(context).size.height/4)
                padding: const EdgeInsets.all(20.0),
                child: new Text("Yes",style: new TextStyle(fontSize:20.0),),
                onPressed: () {
                  updateRequest(post.id);
                  Navigator.of(context).pop();
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UserRequests()),
  ); 
                  
                },
              ),
              new FlatButton(
                padding: const EdgeInsets.all(0.0),
                child: new Text("No",style: new TextStyle(fontSize:20.0),),
                onPressed: () {
                  Navigator.of(context).pop();
                   
                  
                },
              ),
            ],
          );
          }
        );
      },
    )

                    }
                      
                    ),
                    
                  )
                  
                  .toList(),
                  
            );
            
          } else {
            return Text("\n\n\n\n\n\n\nNo drugs responses found",style: new TextStyle(fontSize:20.0),);
          }}else{
            return Center(child: CircularProgressIndicator());
          }
        },
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
