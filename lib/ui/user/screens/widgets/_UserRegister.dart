import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:hello_world/ui/animations/FadeAnimation.dart';
import 'package:hello_world/ui/user/MyHomePage.dart';
import 'package:hello_world/ui/user/config/_AppValication.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/users.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/_UserAdress.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:hello_world/ui/user/screens/widgets/_DoctorRegister.dart';
import 'package:hello_world/ui/user/screens/widgets/_PatientRegister.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserNotes.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRegister extends StatefulWidget {
  final String role;
  UserRegister({Key key, @required this.role}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  //Country _selected;
  Dialogs dialog = new Dialogs();
  double lat;
  double long;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordConfirmController = new TextEditingController();
  final TextEditingController phoneNumberController = new TextEditingController();

  signUp(String email, String password, double lat, double long,String phone) async {
    print("signUp Enter");
    print(email + "|" + password + "|");
    Map data = {
      'email': email,
      'password': password,
      "phoneNumber" : phone,
      'role': widget.role,
      'latitude': lat,
      'longitude': long,
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(API_URL + "/users",
        headers: {"Content-Type": "application/json"}, body: body);
    jsonResponse = json.decode(response.body);

    AppConfig.MAIN_USER = User.fromJson(jsonResponse);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (ALLOWED_USERS.values
            .toString()
            .contains(jsonResponse['user']['role'].toString())) {
          print("TOKEN : " + jsonResponse['token'].toString());
          //print("ROLE : "+jsonResponse['user']['role'].toString());
          sharedPreferences.setString("token", jsonResponse['token']);
          if (AppConfig.MAIN_USER.role == 'Patient') {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => PatientRegister()),
                (Route<dynamic> route) => false);
            print(jsonResponse.toString());
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => DoctorRegister()),
                (Route<dynamic> route) => false);
            print(jsonResponse.toString());
          }
        }
      }
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -120,
                      width: width,
                      height: 250,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 250,
                      top: -90,
                      width: width + 20,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
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
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(width: 0.8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromRGBO(110, 120, 247, 0.5)),
                                  ),
                                  hintText: "Email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(width: 0.8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromRGBO(110, 120, 247, 0.5)),
                                  ),
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: passwordConfirmController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(width: 0.8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromRGBO(110, 120, 247, 0.5)),
                                  ),
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(width: 0.8)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color:
                                            Color.fromRGBO(110, 120, 247, 0.5)),
                                  ),
                                  hintText: "Phone Number",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    size: 30,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              decoration: BoxDecoration(
                                color: address == false
                                    ? Color.fromRGBO(110, 120, 247, 0.5)
                                    : Color.fromRGBO(110, 120, 247, 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print("Select Address");
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return BspAddressmapscreen(
                                        latitudeFinal: (latf) {
                                      setState(() {
                                        lat = latf;
                                        address = true;
                                      });
                                    }, longFinal: (lonf) {
                                      setState(() {
                                        long = lonf;
                                        address = true;
                                      });
                                    });
                                  }));
                                },
                                child: Center(
                                  child: Text(
                                    _textAddress(address),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: InkWell(
                          onTap: () {
                            print("Container clicked");
                            try {
                              print("Long -> " + long.toString());
                              print("Lat -> " + lat.toString());
                            } catch (e) {
                              print("Long -> NULL");
                            }

                            if (!AppValidation.emailValidation(
                                emailController.text)) {
                              dialog.information(context, "Someting Went Wrong",
                                  "Please Check Your Input (Email).");
                            } else {
                              if (!AppValidation.passwordValidation(
                                  passwordController.text,
                                  passwordConfirmController.text)) {
                                dialog.information(
                                    context,
                                    "Someting Went Wrong",
                                    "Please Check Your Input (Password).");
                              } else {
                                if (address) {
                                  signUp(emailController.text,
                                      passwordController.text, lat, long,phoneNumberController.text,);
                                } else {
                                  dialog.information(context, "Select Address",
                                      "Please Check Your Input (Address).");
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          print('Tapped');
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MyHomePage();
                          }));
                        },
                        child: Text(
                          "Already Have Account",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  bool address = false;
  String _textAddress(bool address) {
    if (address) {
      return "Done";
    }
    return "Select Address !!";
  }
}
