import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/data/data.dart';
import 'package:hello_world/ui/user/models/analysis.dart';
import 'dart:math';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckAnalysisProcessByDoctor extends StatefulWidget {
  @override
  _CheckAnalysisProcessByDoctorState createState() =>
      _CheckAnalysisProcessByDoctorState();
}

final _random = new Random();
List<String> images = [
  "male1.png",
  "female1.png",
  "male2.png",
  "female2.png",
  "male3.png",
  "female3.png"
];

List<String> analysisLogos = [
  "analysis1.png",
  "analysis2.png",
  "analysis3.png",
  "analysis4.png",
  "analysis5.png"
];

List<Color> statusColor = [
  Color(0xFF27AA69),
  Color(0xFFDADADA),
  Color(0xFF2B619C),
  Color(0xFFFF0000)
];

String decideUserImage(String gender) {
  return images[_random.nextInt(images.length)];
}

String decideAnalaysisImage() {
  return analysisLogos[_random.nextInt(analysisLogos.length)];
}

Color decideStatusColor(String status) {
  if (status == "Started") {
    return statusColor[2];
  }
  if (status == "Ended" || status == "Rejected") {
    return statusColor[3];
  }
  if (status == "Completed") {
    return statusColor[0];
  }
  if (status == "Waiting") {
    return statusColor[1];
  }
  return statusColor[2];
}

class _CheckAnalysisProcessByDoctorState
    extends State<CheckAnalysisProcessByDoctor> {
  _buildAnalysisProgress(
      BuildContext context, Analysis analysis, analyses, animation) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(height: 20),
            Image(image: AssetImage("assets/images/bar.png")),
            SizedBox(width: 10),
            Column(
              children: <Widget>[
                Text(
                  analysis.status,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
                SizedBox(height: 8),
                Text(
                  analysis.category,
                  style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                ),
                SizedBox(height: 8),
                Text(
                  analysis.description,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    HomeScreen.isCheckingAnalysis = false;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Column(
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () {
              },
              child: Text("Your patient's Analysis Process",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontFamily: 'Poppins')),
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.65,
                  child: Column(
                    children: <Widget>[
                      new Card(
                          elevation: 30,
                          color: new Color(0xff4e37b2),
                          child: Container(
                              child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 88,
                                      minHeight: 88,
                                      maxWidth: 108,
                                      maxHeight: 108,
                                    ),
                                    child: HomeScreen.homePatient.owner.avatar
                                                .length <
                                            15
                                        ? AssetImage("assets/images/" +
                                            decideUserImage("eeee"))
                                        : Image.network(
                                            HomeScreen.homePatient.owner.avatar,
                                          ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 7,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8),
                                    Text(
                                      "Address: " +
                                          HomeScreen.homePatient.owner.address,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Patient CIN: " +
                                          HomeScreen.homePatient.cin,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Patient Name: " +
                                          HomeScreen.homePatient.name
                                              .capitalize(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Patient Lastname: " +
                                          HomeScreen.homePatient.lastName
                                              .capitalize(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Patient CNSS Number: " +
                                          HomeScreen.homePatient.cnssNumber,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Patient Phone: " + "Number",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ))),
                      new Flexible(
                          child: FutureBuilder(
                        future: httpService.getPatientAnalysisResults(
                            HomeScreen.homePatient.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Analysis>> snapshot) {
                          if (snapshot.hasData) {
                            List<Analysis> analyses = snapshot.data;
                            return Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  for (var index = 0;
                                      index < analyses.length;
                                      index++)
                                    prepareTile(analyses[index], index,
                                        analyses.length),
                                ],
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height / 13)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

Widget prepareTile(Analysis analysis, int index, int length) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineX: 0.1,
    isFirst: index == 0 ? true : false,
    isLast: index == length - 1 ? true : false,
    indicatorStyle: IndicatorStyle(
      width: 20,
      color: decideStatusColor(analysis.status),
      padding: EdgeInsets.all(6),
    ),
    rightChild: _RightChild(
      asset: 'assets/images/' + decideAnalaysisImage(),
      title: analysis.category,
      message: analysis.description,
    ),
    topLineStyle: LineStyle(
      color: decideStatusColor(analysis.status),
    ),
  );
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
