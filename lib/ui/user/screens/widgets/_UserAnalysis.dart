import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/screens/widgets/_LabProfile.dart';
import 'package:hello_world/ui/user/screens/widgets/lap_clipper.dart';

class UserAnalysis extends StatefulWidget {
  final List<Analysis> analyses;
  UserAnalysis({Key key, @required this.analyses}) : super(key: key);
  @override
  _UserAnalysisState createState() => _UserAnalysisState();
}

class _UserAnalysisState extends State<UserAnalysis> {
  _buildAnalysis(BuildContext context, Analysis analysis) {
    return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.0, color: Colors.grey[200])),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipPath(
                  clipper: LapClipper(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          IMG_SERVER + analysis.laboratory.coverPicture),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return LabProfile(laboratory: analysis.laboratory,);
                        }));
                      },
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              IMG_SERVER + analysis.laboratory.owner.avatar)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(analysis.laboratory.name.capitalize(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400,
                        )),
                    // SizedBox(
                    //   height: 15,
                    // ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 150,
                  //margin: EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                      color: getStatusColor(analysis.status),
                      //color: Color.fromRGBO(49, 39, 79, 1),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      analysis.status,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      //color: Color.fromRGBO(49, 39, 79, 1),
                      border: Border.all(
                        width: 1.0,
                        color: Color.fromRGBO(110, 120, 247, 1),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      analysis.category,
                      style: TextStyle(
                        color: Color.fromRGBO(110, 120, 247, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.5, color: Colors.grey[300])),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 30, left: 10, right: 10),
                  child: Text(analysis.description,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Poppins',
                      )),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                      AppConfig.dateFormatAppointment(analysis.dateAnalyse),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          IMG_SERVER + analysis.doctor.owner.avatar)),
                )
              ],
            ),
          ],
        )
        // Row(
        //   //mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Padding(
        //       padding: EdgeInsets.all(15),
        //       child: CircleAvatar(
        //           radius: 50,
        //           backgroundImage:
        //               NetworkImage('https://via.placeholder.com/140x100')),
        //     ),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           SizedBox(
        //             height: 20,
        //           ),
        //           Text(analysis.doctor.name + analysis.doctor.lastName,
        //               style: TextStyle(
        //                 fontSize: 20.0,
        //                 fontFamily: 'Raleway',
        //                 fontWeight: FontWeight.w400,
        //               )),
        //           Text('Tues Nov 9, 2020',
        //               style: TextStyle(
        //                 fontSize: 15.0,
        //                 fontFamily: 'Poppins',
        //                 fontWeight: FontWeight.w300,
        //               )),
        //           SizedBox(
        //             height: 20,
        //           ),
        //           Container(
        //             margin: EdgeInsets.only(right: 25),
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(8),
        //                 border: Border.all(width: 0.5, color: Colors.grey[300])),
        //             child: Padding(
        //               padding: EdgeInsets.only(
        //                   top: 5, bottom: 30, left: 10, right: 10),
        //               child: Text(analysis.description,
        //                   style: TextStyle(
        //                     fontSize: 18.0,
        //                     fontFamily: 'Poppins',
        //                   )),
        //             ),
        //           )
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Analysis',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 400,
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          //color: Colors.blue,
          child: ListView.builder(
              itemCount: widget.analyses.length,
              itemBuilder: (BuildContext context, int index) {
                Analysis analysis = widget.analyses[index];
                return _buildAnalysis(context, analysis);
              }),
        ),
      ],
    );
  }
}

Color getStatusColor(String status) {
  if (status == 'Ended') {
    return Colors.green;
  } else if (status == 'Waiting') {
    return Colors.yellow;
  } else if (status == 'Started') {
    return Colors.blueAccent;
  } else {
    return Colors.red;
  }
}
