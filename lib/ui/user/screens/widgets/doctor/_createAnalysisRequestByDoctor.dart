import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/services/http_service.dart';

class CreateAnalysisRequestByDoctor extends StatefulWidget {
  
  @override
  _CreateAnalysisRequestByDoctorState createState() => _CreateAnalysisRequestByDoctorState();

}

class _CreateAnalysisRequestByDoctorState extends State<CreateAnalysisRequestByDoctor> {
    
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   HomeScreen.isCreatingAnalysis = false;
    // });
    print("=====");
    print(HomeScreen.homePatient.id);
    TextEditingController categoryController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    return SingleChildScrollView(
      child : Container(
      height: MediaQuery.of(context).size.height/1.65,
              child: Column(
        children: <Widget>[
          Text("Create Analysis Request",style: TextStyle(color: Colors.black,fontSize: 23.0),),
          SizedBox(height: 10,),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Category Description",
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        controller: categoryController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Analysis Description",
                          contentPadding: EdgeInsets.all(15.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        controller: descriptionController,
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: () {
                        HomeScreen.isCreatingAnalysis = false;
                          httpService.createAnalysisByDoctor(descriptionController.text, categoryController.text, HomeScreen.homePatient.id);
                          Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Analysis Created !"),
                        ));
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            'Submit Request',
                            style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            )
        ],
    ),
      ),
    );
  }
}

