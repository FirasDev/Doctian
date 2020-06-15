import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/DrugRequest.dart';
import 'package:hello_world/ui/user/models/Drugs.dart';
import 'package:hello_world/ui/user/models/perscription.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import '_UserRequests.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:geocoder/geocoder.dart';

class UserPrescriptions extends StatefulWidget {
  final List<Perscription> prescriptions;
  UserPrescriptions({Key key, @required this.prescriptions}) : super(key: key);

  @override
  _UserPrescriptionsState createState() => _UserPrescriptionsState();
}

class _UserPrescriptionsState extends State<UserPrescriptions> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<Drugs>> key = new GlobalKey();
  Dialogs dialog = new Dialogs();
  bool loading = true;
  var addresses;
  var first;
  final quantityVal = TextEditingController();
  AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();
  static List<Drugs> drugs = new List<Drugs>();
  var currentLocation;
  List<DrugRequest> user;

  @override
  void initState() {
    getDrugs();
    _getLocation();
  }

  Future<List<DrugRequest>> getRequests() async {
    final String pendingpostsURL =
        API_URL + "/Pendingdrugreqs/" + AppConfig.MAIN_PATIENT.id;
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

  _getLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    currentLocation = first.adminArea;
    print(currentLocation);
  }

  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              // use container to change width and height

              title: new Text(
                "Drug request",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 25.0),
              ),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: searchTextField = AutoCompleteTextField<Drugs>(
                            key: key,
                            clearOnSubmit: false,
                            suggestions: drugs,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              labelText: "Drug",
                              hintText: "Search Drug",
                              hintStyle: TextStyle(),
                            ),
                            itemFilter: (item, query) {
                              return item.name
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.name.compareTo(b.name);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text =
                                    item.name;
                              });
                            },
                            itemBuilder: (context, item) {
                              // ui for the autocompelete row
                              return Wrap(
                                children: <Widget>[
                                  Text(
                                    item.name,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              );
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty || int.parse(value) < 1) {
                                  return 'Please enter a valid quantity';
                                }
                                return null;
                              },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              controller: quantityVal,
                              decoration:
                                  InputDecoration(labelText: 'Quantity'),
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  height: 2.0,
                                  color: Colors.black))),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(""),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ButtonTheme(
                          buttonColor: Colors.blue,
                          minWidth: 200.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          child: RaisedButton(
                            onPressed: () {
                              if (searchTextField
                                  .textField.controller.text.isEmpty) {
                                dialog.information(context, "Warning",
                                    "Please enter a drug name!");
                              } else if (_formKey.currentState.validate()) {
                                postMed(
                                    searchTextField.textField.controller.text,
                                    quantityVal.text);
                                Navigator.of(context).pop();
                                dialog.information(context, "Drug request",
                                    "Your drug request was successful!");
                                setState(() {});
                              }
                            },
                            child: Text(
                              'Submit',
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void getDrugs() async {
    try {
      final response = await http.get(
          "https://produits-sante.canada.ca/api/medicament/drugproduct/?lang=fr&type=json");
      if (response.statusCode == 200) {
        drugs = loadDrugs(response.body);
        print('Drugs: ${drugs.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting drugs.");
      }
    } catch (e) {
      print("Error getting drugs.");
    }
  }

  static List<Drugs> loadDrugs(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Drugs>((json) => Drugs.fromJson(json)).toList();
  }

  Future postMed(med, quantity) async {
    String apiUrl = API_URL +
        '/patient/medicament/' +
        AppConfig.MAIN_USER.id +
        '/' +
        med +
        '/' +
        quantity +
        '/' +
        currentLocation;
    http.Response response = await http.post(apiUrl, headers: {}, body: {});
    print("Result: ${response.body}");
    return json.decode(response.body);
  }

  Future postContact(presId) async {
    String apiUrl = API_URL +
        '/patient/perscription/' +
        presId +
        '/' +
        AppConfig.MAIN_USER.id +
        '/' +
        currentLocation;
    http.Response response = await http.post(apiUrl, headers: {}, body: {});
    print("Result: ${response.body}");
    return json.decode(response.body);
  }

  _buildPerscriptions(BuildContext context, Perscription perscription) {
    return Container(
      margin: EdgeInsets.all(10.0),
      //height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: Colors.grey[200])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage(IMG_SERVER + perscription.doctor.owner.avatar)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                        perscription.doctor.name + perscription.doctor.lastName,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Tues Nov 9, 2020',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        )),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 20, left: 25, right: 25),
            child: Text(perscription.perscriptionDescription,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Poppins',
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('Make Request',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      )),
                  color: Color.fromRGBO(110, 120, 247, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  onPressed: () {
                    postContact(perscription.id);
                    dialog.information(context, "Request confirmation",
                        "Your request was sent");
                    setState(() {});
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Prescriptions',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: FutureBuilder(
                    future: getRequests(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<DrugRequest>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isEmpty) {
                          return RaisedButton(
                            child: Text('My Requests',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                )),
                            color: Color.fromRGBO(210, 210, 210, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            onPressed: () {},
                          );
                        } else {
                          return RaisedButton(
                            child: Text('My Requests',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                )),
                            color: Color.fromRGBO(110, 120, 247, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserRequests()),
                              );
                            },
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 400,
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
//color: Colors.blue,
          child: ListView.builder(
              itemCount: widget.prescriptions.length,
              itemBuilder: (BuildContext context, int index) {
                Perscription perscription = widget.prescriptions[index];
                return _buildPerscriptions(context, perscription);
              }),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            width: 60,
                            height: 60,
                            child: Image.asset('assets/images/btn_ic_doc.png')),
                        onTap: () {
                          _showDialog2();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
