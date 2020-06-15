import 'package:hello_world/covid/ui/constant.dart';
import 'package:hello_world/covid/ui/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/patient.svg",
              textTop: "Learn more",
              textBottom: "About Covid-19.",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "SYMPTOMS",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 30,),
                        SymptomCard(
                          image: "assets/images/coughing_guy.png",
                          title: "Caughing",
                          isActive: true,
                        ),
                        SymptomCard(
                          image: "assets/images/fever_guy.png",
                          title: "Fever",
                        ),
                        SymptomCard(
                          image: "assets/images/headache_guy.png",
                          title: "Headache",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("PREVENTION", style: kTitleTextstyle),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                        "According to the world health organization (WHO) this is the best way to keep yourself from getting infected",
                    image: "assets/images/hand_wash.png",
                    title: "Wash your hands",
                  ),
                  PreventCard(
                    text:
                        "Avoid close contact with anyone outside your family circle and keep contact with people to a minimum",
                    image: "assets/images/handshake.png",
                    title: "Social distancing",
                  ),
                  PreventCard(
                    text:
                        "Face masks have proved to be a huge tool to combat this virus and it is mandatory in most countries",
                    image: "assets/images/mask.png",
                    title: "Wear a face mask",
                  ),
                  PreventCard(
                    text:
                        "We touch our faces way too many times. And cutting down on that will help stop the spread of the virus",
                    image: "assets/images/face_touch.png",
                    title: "Face touching",
                  ),
                  PreventCard(
                    text:
                        "Avoid eating raw or undercooked animal products (meat, milk, etc..) cook it properly and wash your hand after handling ingredients",
                    image: "assets/images/cooking.png",
                    title: "Cook your food properly",
                  ),
                  PreventCard(
                    text:
                        "Travel is banned in most countries, but some people are able to find ways around this and it only puts them and us in danger, refrain from doing this",
                    image: "assets/images/no_plane.png",
                    title: "Don't travel anywhere",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
