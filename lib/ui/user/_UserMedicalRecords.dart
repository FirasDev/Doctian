import 'package:flutter/material.dart';

class UserMedicalRecords extends StatefulWidget {
  @override
  _UserMedicalRecordsState createState() => _UserMedicalRecordsState();
}

class _UserMedicalRecordsState extends State<UserMedicalRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(245, 245, 245, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color: Color.fromRGBO(110, 120, 247, 1),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.account_circle),
                            color: Colors.white,
                            onPressed: () {}),
                        Text("SaifEddine Rhouma")
                      ],
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.white,
                      onPressed: () {}),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //FlatButton(onPressed: () {}, child: Text("Notes")),
              //FlatButton(onPressed: () {}, child: Text("Prescription")),
              Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                      'assets/images/btn_ic_doc.png')),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Doctor")
                    ],
                  )),
              Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                      'assets/images/btn_ic_med.png')),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Medicines")
                    ],
                  )),
              Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOvalShadow(
                        shadow: Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 6,
                        ),
                        clipper: CustomClipperOval(),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                      'assets/images/btn_ic_diag.png')),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Digonostic")
                    ],
                  )),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // PUBLICATION
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 300,
                child: ListView(
                  children: <Widget>[
                    _buildDataItem(Icons.assignment, "My Doctors"),
                    _buildDataItem(Icons.assignment, "Appointments"),
                    _buildDataItem(Icons.assignment, "Medical records"),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDataItem(IconData icon, String title) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container());
  }
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;
  final Widget child;

  ClipOvalShadow({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipRect(child: child, clipper: this.clipper),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Rect> clipper;

  _ClipOvalShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(0, 0));
    canvas.drawOval(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
