import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/screens/_HomeNotes.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/ui/animations/FadeAnimation.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatar extends StatefulWidget {
  @override
  _UploadAvatarState createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            height: 190.0,
            width: 190.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: const Color(0x33A6A6A6)),
              image: DecorationImage(
                  image: Image.file(
                    snapshot.data,
                    fit: BoxFit.fill,
                  ).image,
                  fit: BoxFit.cover),
            ),
          );
        } else if (null != snapshot.error) {
          return Image.network(
            IMG_SERVER + 'avatar.jpg',
          );
        } else {
          return Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          IMG_SERVER + AppConfig.MAIN_USER.avatar))));
        }
      },
    );
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  uploadImage() {
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    //print("Token From SP : " + value);
    // var response = await http.get(API_URL + "/patient/notes/", headers: {
    //   "Content-Type": "application/json",
    //   "Authorization": "Bearer $value"
    // });
    var jsonResponse = null;
    var response = await http.post(API_URL + "/users/avatar",
        headers: {"Authorization": "Bearer $value"},
        body: {"file": base64Image});

    // .then((result) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => HomeNotes()),
    //       (Route<dynamic> route) => false);
    // }).catchError((error) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => HomeNotes()),
    //       (Route<dynamic> route) => false);
    //   print('Error Upload');
    // });
    print('Upload Success');
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse['ImageName'].toString());
      AppConfig.MAIN_USER.avatar = jsonResponse['ImageName'];
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeNotes()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeNotes()),
          (Route<dynamic> route) => false);
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
                      "Upload Avatar",
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
                      width: width,
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
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: InkWell(
                              onTap: () {
                                chooseImage();
                              },
                              child: showImage(),
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
                            // signUp(emailController.text,
                            //     passwordController.text, _selected);
                            uploadImage();
                          },
                          child: Center(
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          print('Tapped');
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return HomeNotes();
                          }));
                        },
                        child: Text(
                          "Skip ..",
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
