import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/screens/widgets/_Dialogs.dart';

class UserMakeRequest extends StatefulWidget {
  @override
  _UserMakeRequestState createState() => _UserMakeRequestState();
}

class _UserMakeRequestState extends State<UserMakeRequest> {
  Dialogs dialog = new Dialogs();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      //height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.0, color: Colors.grey[200])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 5, left: 25, right: 25),
            child: Text('Write You Prescriptions : ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                )),
          ),
          Container(
            margin: EdgeInsets.only(top:10,left:25,right: 25),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 0.5, color: Colors.grey[300])),
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: TextField(
                //controller: _textEditingController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write Here",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                  ),
                ),
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Poppins',
                ),
                maxLines: 6,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('Make Request',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      )),
                  color: Color.fromRGBO(110, 120, 247, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  onPressed: () {
                    dialog.information(context, "title", "description");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
