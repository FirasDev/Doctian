import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:hello_world/ui/animations/FadeAnimation.dart';
import 'package:hello_world/ui/user/_UserHome.dart';
import 'package:hello_world/ui/user/config/_AppValication.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/users.dart';
import 'package:hello_world/ui/user/screens/_UserAdress.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditUserAccount extends StatefulWidget {
  final String role;
  EditUserAccount({Key key, @required this.role}) : super(key: key);
  @override
  _EditUserAccountState createState() => _EditUserAccountState();
}

class _EditUserAccountState extends State<EditUserAccount> {
  //Country _selected;

  Dialogs dialog = new Dialogs();
  double lat;
  double long;
  String textModification = "Confirm Modification";

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordConfirmController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = AppConfig.MAIN_USER.email;
    lat = AppConfig.MAIN_USER.latitude;
    long = AppConfig.MAIN_USER.longitude;
    passwordController.text = "********";
    passwordConfirmController.text = "********";
  }

  editAccount(String email, String password, double lat, double long) async {
    Map data;
    if (password.compareTo('********') == 0) {
      data = {
        'email': email,
        'latitude': lat,
        'longitude': long,
      };
    } else {
      data = {
        'email': email,
        'password': password,
        'latitude': lat,
        'longitude': long,
      };
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    var body = json.encode(data);
    var jsonResponse = null;

    var response = await http.patch(API_URL + "/users/me",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        },
        body: body);

    jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      AppConfig.MAIN_USER = User.ownerfromJson(jsonResponse); 
      if (jsonResponse != null) {
        setState(() {
          textModification = "Modification Done";
        });
        dialog.information(context, "Modification Success",
            "Your account has been successfully modified.");
      }
    } else {
      setState(() {
        textModification = "Modification FAIL";
        dialog.information(
            context, "Modification Fail", "Something went Wrong!! try again.");
      });
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
                    ),
                    Positioned(
                      top: 35,
                      left: 10,
                      //width: width + 20,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, a1, a2) => UserHome()),
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Edit User Account",
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
                                          color: Color.fromRGBO(
                                              110, 120, 247, 0.5)),
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
                                          color: Color.fromRGBO(
                                              110, 120, 247, 0.5)),
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
                                          color: Color.fromRGBO(
                                              110, 120, 247, 0.5)),
                                    ),
                                    hintText: "Confirm Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      size: 30,
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //       border: Border(
                            //           bottom:
                            //               BorderSide(color: Colors.grey[300]))),
                            //   child: CountryPicker(
                            //     showDialingCode: false,
                            //     dense: false,
                            //     showFlag: true,
                            //     showName: true,
                            //     showCurrency: false,
                            //     showCurrencyISO: false,
                            //     onChanged: (Country country) {
                            //       setState(() {
                            //         _selected = country;
                            //       });
                            //     },
                            //     selectedCountry: _selected,
                            //   ),
                            // ),
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
                                    Navigator.push(context,
                                        new MaterialPageRoute(
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
                              print("lat : > " + lat.toString());
                              // signUp(emailController.text,
                              //     passwordController.text, _selected);

                              if (!AppValidation.emailValidation(
                                  emailController.text)) {
                                dialog.information(
                                    context,
                                    "Someting Went Wrong",
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
                                  editAccount(emailController.text,
                                      passwordController.text, lat, long);
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                textModification,
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
              )
            ],
          ),
        ));
  }

  bool address = false;
  String _textAddress(bool address) {
    if (address) {
      return "Changed";
    }
    return "Done";
  }
}
