import 'package:flutter/material.dart';
import 'search_dotors_info.dart';


class BookAppointmentsInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/doc_patient.png"),
                  Text("Appointment Booking",
                  style: TextStyle(fontSize: 25.0,fontFamily: "Poppins-Medium",fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 10.0),
                    child: Text("Book an appointment with the right doctor for you.",
                    style: TextStyle(fontSize: 16.0,fontFamily: "Poppins-medium"),
                    textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchDoctorsInfo()));
                      },
                      child: Image.asset("assets/images/next_btn.png"),
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}