import 'package:flutter/foundation.dart';
import 'speciality.dart';
import 'package:flutter/material.dart';
import 'doctors_list_by_speciality.dart';

class SpecialityList extends StatelessWidget {
  final List<Speciality> speciality;
  SpecialityList({Key key,this.speciality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: speciality == null ? 0 : speciality.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(right: 40.0,left: 40.0),
          child: new Card(
            elevation: 0,
            child: new Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.2)),),
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(speciality[index].name == null ? "empty" : speciality[index].name,
                    style: TextStyle(
                      fontFamily: "Poppins-medium", 
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0),
                      ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsListBySpeciality(passedSpeciality: speciality[index].name)));
                    },
                    )
                  ],
                ),
              ),
              padding: const EdgeInsets.all(15.0),
            ),
          ),
        );
      });
  }
}