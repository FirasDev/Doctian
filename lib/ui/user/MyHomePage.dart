import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/_AppValication.dart';
import 'package:hello_world/ui/user/models/doctor.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/models/pharmaceuticalCompany.dart';
import 'package:hello_world/ui/user/models/users.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/screens/widgets/Statistics.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';
import 'package:hello_world/ui/user/screens/widgets/_UserRegister.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../animations/FadeAnimation.dart';
import 'config/config.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dialogs dialog = new Dialogs();
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  checkSession() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      print('Awaiting user Session...');
      final key = 'token';
      final value = sharedPreferences.getString(key) ?? 0;
      print('Session Token : ' + value.toString());
      if (value != 0) {
        var response = await http.get(API_URL + "/users", headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $value"
        });
        var jsonResponse = null;
        print("APi Response Status : " + response.statusCode.toString());
        print("APi Response : " + response.body.toString());
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          AppConfig.MAIN_USER = User.fromJson(jsonResponse);

          if (AppConfig.MAIN_USER.role.contains('Patient')) {
            AppConfig.MAIN_PATIENT = Patient.patientFromJson(jsonResponse);
          } else if (AppConfig.MAIN_USER.role
              .contains('Pharmaceutical company')) {
            AppConfig.MAIN_PHARMCOM =
                PharmaceuticalCompany.fromJson(jsonResponse);
          } else {
            AppConfig.MAIN_DOCTOR = Doctor.doctorFromJson(jsonResponse);
          }
          if (jsonResponse != null) {
            if (ALLOWED_USERS.values.toString().toUpperCase().contains(
                jsonResponse['user']['role']
                    .toString()
                    .replaceAll(" ", "")
                    .toUpperCase())) {
              if (AppConfig.MAIN_USER.role.contains('Patient')) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeNotes()),
                    (Route<dynamic> route) => false);
              } else if (AppConfig.MAIN_USER.role
                  .contains('Pharmaceutical company')) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => StatPage()),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              }
            }
          } else {
            dialog.information(context, "Connection Fail",
                "Eather The Server is Down Or You Don't a Connection");
          }
        }
      }
      print("Token From SP : " + value);
    } catch (err) {
      print('Caught error: $err');
    }
  }

  signIn(String email, String password) async {
    Map data = {'email': email, 'password': password};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("DATA : " + data['email']);
    var body = json.encode(data);
    var jsonResponse = null;
    var response = await http.post(API_URL + "/users/login",
        headers: {"Content-Type": "application/json"}, body: body);
    print("APi Response Status : " + response.statusCode.toString());
    print("APi Response : " + response.body.toString());
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      // AppConfig(MAIN_USER: User.fromJson(jsonResponse));
      AppConfig.MAIN_USER = User.fromJson(jsonResponse);

      if (AppConfig.MAIN_USER.role.contains('Patient')) {
        AppConfig.MAIN_PATIENT = Patient.patientFromJson(jsonResponse);
      } else if (AppConfig.MAIN_USER.role.contains('Pharmaceutical company')) {
        AppConfig.MAIN_PHARMCOM = PharmaceuticalCompany.fromJson(jsonResponse);
      } else {
        AppConfig.MAIN_DOCTOR = Doctor.doctorFromJson(jsonResponse);
      }

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
       
        if (ALLOWED_USERS.values.toString().toUpperCase().contains(
            jsonResponse['user']['role']
                .toString()
                .replaceAll(" ", "")
                .toUpperCase())) {
          sharedPreferences.setString("token", jsonResponse['token']);
          if (AppConfig.MAIN_USER.role.contains('Patient')) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeNotes()),
                (Route<dynamic> route) => false);
          } else if (AppConfig.MAIN_USER.role
              .contains('Pharmaceutical company')) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => StatPage()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    (Route<dynamic> route) => false);
          }
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkSession();
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
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -100,
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background.png'),
                                  fit: BoxFit.fitHeight)),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 400,
                      top: -60,
                      width: width + 20,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fitWidth)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Color(0xff464ea8),
                          fontWeight: FontWeight.bold,
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
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
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
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Center(
                    //   child: Text(
                    //     "Forgot Password?",
                    //     style: TextStyle(
                    //       color: Color.fromRGBO(49, 39, 79, 1),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                            color: Color(0xff464ea8),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              print("Container clicked");
                              if (!AppValidation.emailValidation(
                                  emailController.text)) {
                                dialog.information(
                                    context,
                                    "Someting Went Wrong",
                                    "Please Check Your Input (Email).");
                              } else {
                                if (AppValidation.passwordValidationLogin(
                                    passwordController.text)) {
                                  dialog.information(
                                      context,
                                      "Someting Went Wrong",
                                      "Please Check Your Input (Password).");
                                } else {
                                  signIn(emailController.text,
                                      passwordController.text);
                                }
                              }
                            },
                            child: Text(
                              "Login",
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
                          dialog.registerRoleChoose(context, "Register As");
                          // Navigator.push(context, new MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return UserRegister();
                          // }));
                        },
                        child: Text(
                          "Create Account",
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
}
