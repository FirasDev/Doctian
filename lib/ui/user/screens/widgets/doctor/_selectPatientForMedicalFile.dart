import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/ui/user/models/patient.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/screens/widgets/doctor/_createAnalysisRequestByDoctor.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'package:hello_world/ui/user/config/config.dart';

class SelectPatientForMedicalFile extends StatefulWidget {
  @override
  _SelectPatientForMedicalFileState createState() =>
      _SelectPatientForMedicalFileState();
}

final _random = new Random();
List<String> images = [
  "male1.png",
  "female1.png",
  "male2.png",
  "female2.png",
  "male3.png",
  "female3.png",
];

List<String> statusList = ['Accepted', 'Rejected', 'Pending', 'Waiting'];

List<Patient> _searchResult = [];
List<Patient> _userDetails = [];
TextEditingController controller = new TextEditingController();

String decideUserImage(String gender) {
  return images[_random.nextInt(images.length)];
}

final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
final headerTextStyle = baseTextStyle.copyWith(
    color: new Color(Colors.black.value),
    fontSize: 18.0,
    fontWeight: FontWeight.w600);
final regularTextStyle = baseTextStyle.copyWith(
    color: Color(Colors.grey.value),
    fontSize: 14.0,
    fontWeight: FontWeight.w400);
final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 14.0);

class _SelectPatientForMedicalFileState
    extends State<SelectPatientForMedicalFile> {
  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        elevation: 6,
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    print(_userDetails);
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text) || userDetail.lastName.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        Patient patient = _searchResult[i];
        return GestureDetector(
          onTap: () {
            this.setState(() {
              HomeScreen.isCheckingMedicalFile = true;
              HomeScreen.homePatient = patient;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          child: Card(
            color: new Color(0xFFc4c9ff),
            elevation: 2,
            child: ListTile(
              title: Text(
                patient.name.capitalize() + " " + patient.lastName.capitalize(),
                style: headerTextStyle,
              ),
              subtitle: Text(patient.owner.email, style: subHeaderTextStyle),
              leading: CircleAvatar(
                maxRadius: 22,
                backgroundImage: patient.owner.avatar.length < 15
                    ? AssetImage("assets/images/" + decideUserImage("eeee"))
                    : NetworkImage(patient.owner.avatar, scale: 30),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildPatientsList(
      BuildContext context, Patient patient, patients, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: new GestureDetector(
        onTap: () {
          this.setState(() {
            HomeScreen.isCheckingMedicalFile = true;
            HomeScreen.homePatient = patient;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Card(
          color: new Color(0xFFc4c9ff),
          elevation: 2,
          child: ListTile(
            title: Text(
              patient.name.capitalize() + " " + patient.lastName.capitalize(),
              style: headerTextStyle,
            ),
            subtitle: Text(
              patient.owner.email,
              style: subHeaderTextStyle,
            ),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundImage: patient.owner.avatar.length < 15
                  ? AssetImage("assets/images/" + decideUserImage("eeee"))
                  : NetworkImage(patient.owner.avatar, scale: 22),
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.65,
        child: Column(
          children: <Widget>[
            Text(
              "Select your patient",
              style: TextStyle(color: Colors.black, fontSize: 23.0),
            ),
            SizedBox(
              height: 10,
            ),
            new Container(color: Colors.white, child: _buildSearchBox()),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? _buildSearchResults()
                    : FutureBuilder(
                        future: httpService.getMyPatientsList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Patient>> snapshot) {
                          if (snapshot.hasData) {
                            List<Patient> patients = snapshot.data;
                            _userDetails = patients;
                            return AnimatedList(
                                key: _key,
                                initialItemCount: patients.length,
                                itemBuilder: (BuildContext context, int index,
                                    Animation animation) {
                                  Patient patient = patients[index];
                                  return _buildPatientsList(
                                      context, patient, patients, animation);
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
