import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/notes.dart';
import 'package:hello_world/ui/user/screens/widgets/_DoctorProfile.dart';

class UserNotes extends StatefulWidget {
  final List<Notes> notes;
  UserNotes({Key key, @required this.notes}) : super(key: key);

  @override
  _UserNotesState createState() => _UserNotesState();
}

class _UserNotesState extends State<UserNotes> {
  _buildNotesFinal(List<Notes> notes) {
    List<Widget> notesList = [];
    notes.forEach((Notes note) {
      notesList.add(Container(
        margin: EdgeInsets.all(10.0),
        height: 250,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.0, color: Colors.grey[200])),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/140x100')),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text('Selin Jose',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w400,
                      )),
                  Text('Tues Nov 9, 2020',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(width: 0.5, color: Colors.grey[300])),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 30, left: 10, right: 10),
                      child: Text(
                          'The Mentalist - Patrick Jane & Red John - Tribute - Complete Storyline',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));
    });
    return Column(children: notesList);
  }

  _buildNotes(BuildContext context, Notes note) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: Colors.grey[200])),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                print('Tapped');
                AppConfig.SELECTED_DOCTOR = note.doctor;
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return DoctorProfile(
                    doctor: note.doctor,
                  );
                }));
              },
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(IMG_SERVER + note.doctor.owner.avatar)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(note.doctor.name + " " + note.doctor.lastName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w400,
                    )),
                Text(AppConfig.dateFormat(note.createDate),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.grey[300])),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 30, left: 10, right: 10),
                    child: Text(note.notesDetails,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Doctors Notes',
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
          height: 390,
          
          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          //color: Colors.blue,
          child: ListView.builder(
            shrinkWrap: true,
              itemCount: widget.notes.length,
              itemBuilder: (BuildContext context, int index) {
                Notes note = widget.notes[index];
                return _buildNotes(context, note);
              }),
        ),
      ],
    );
  }
}
