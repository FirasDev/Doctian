import 'package:flutter/material.dart';
import 'package:hello_world/ui/user/data/data.dart';
import 'package:hello_world/ui/user/models/analysis.dart';
import 'package:hello_world/ui/user/models/analysisResult.dart';
import 'dart:math';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'package:hello_world/ui/user/services/http_service.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/ui/user/screens/_Home_screen.dart';
import 'dart:async';

class CheckMedicalFile extends StatefulWidget {
  @override
  _CheckCheckMedicalFileState createState() => _CheckCheckMedicalFileState();
}

final HttpService httpService = HttpService();

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

Future<Image> convertIpfsToPng(String ipfsUrl) async {
  final url = await httpService.getIpfsConvertedLink(ipfsUrl);
  String result = url.replaceAll('localhost', IP_ADDRESS); 
  return Image.network("http://"+result);
}

Widget _buildAnalysisList(context, analysisResult, analysisRes, animation) {
  
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: ExpansionTileCard(
      leading:
          CircleAvatar(child: Image.asset("assets/images/chokri_hammouda.png")),
      title: Text(analysisResult.analysis.category),
      subtitle: Text('Tap to see more!'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              analysisResult.description,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: new FutureBuilder(
                future: convertIpfsToPng(analysisResult.ipfsURL),
                builder: (BuildContext context, AsyncSnapshot<Image> image) {
                  if (image.hasData) {
                    return GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: image.data
        ),
        onTap: () {
          DetailScreen.image = image.data;
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen();
          }));
        },
      ); // image is ready
                  } else {
                    return CircularProgressIndicator(); // placeholder
                  }
                },
              )),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: 52.0,
          buttonMinWidth: 90.0,
          children: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(Icons.file_download),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text('Save'),
                ],
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Icon(Icons.forward),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text('Share'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class DetailScreen extends StatefulWidget {
  static Image image;
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Image myImage = DetailScreen.image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: myImage
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ExpansionTileCard extends StatefulWidget {
  const ExpansionTileCard({
    Key key,
    this.leading,
    @required this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.elevation = 2.0,
    this.initiallyExpanded = false,
    this.initialPadding = EdgeInsets.zero,
    this.finalPadding = const EdgeInsets.symmetric(vertical: 6.0),
    this.contentPadding,
    this.baseColor,
    this.expandedColor,
    this.duration = const Duration(milliseconds: 200),
    this.elevationCurve = Curves.easeOut,
    this.heightFactorCurve = Curves.easeIn,
    this.turnsCurve = Curves.easeIn,
    this.colorCurve = Curves.easeIn,
    this.paddingCurve = Curves.easeIn,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  final Widget trailing;

  final BorderRadiusGeometry borderRadius;

  final double elevation;

  final bool initiallyExpanded;

  final EdgeInsetsGeometry initialPadding;

  final EdgeInsetsGeometry finalPadding;

  final EdgeInsetsGeometry contentPadding;

  final Color baseColor;

  final Color expandedColor;

  final Duration duration;

  final Curve elevationCurve;

  final Curve heightFactorCurve;

  final Curve turnsCurve;

  final Curve colorCurve;

  final Curve paddingCurve;

  @override
  _ExpansionTileCardState createState() => _ExpansionTileCardState();
}

class _ExpansionTileCardState extends State<ExpansionTileCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _materialColorTween = ColorTween();
  EdgeInsetsTween _edgeInsetsTween;
  Animatable<double> _elevationTween;
  Animatable<double> _heightFactorTween;
  Animatable<double> _turnsTween;
  Animatable<double> _colorTween;
  Animatable<double> _paddingTween;

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<double> _elevation;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;
  Animation<Color> _materialColor;
  Animation<EdgeInsets> _padding;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _edgeInsetsTween = EdgeInsetsTween(
      begin: widget.initialPadding,
      end: widget.finalPadding,
    );
    _elevationTween = CurveTween(curve: widget.elevationCurve);
    _heightFactorTween = CurveTween(curve: widget.heightFactorCurve);
    _colorTween = CurveTween(curve: widget.colorCurve);
    _turnsTween = CurveTween(curve: widget.turnsCurve);
    _paddingTween = CurveTween(curve: widget.paddingCurve);

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(_heightFactorTween);
    _iconTurns = _controller.drive(_halfTween.chain(_turnsTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_colorTween));
    _materialColor = _controller.drive(_materialColorTween.chain(_colorTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_colorTween));
    _elevation = _controller.drive(
        Tween<double>(begin: 0.0, end: widget.elevation)
            .chain(_elevationTween));
    _padding = _controller.drive(_edgeInsetsTween.chain(_paddingTween));
    _isExpanded = PageStorage.of(context)?.readState(context) as bool ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Padding(
      padding: _padding.value,
      child: Material(
        type: MaterialType.card,
        color: _materialColor.value,
        borderRadius: widget.borderRadius,
        elevation: _elevation.value,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                customBorder:
                    RoundedRectangleBorder(borderRadius: widget.borderRadius),
                onTap: _handleTap,
                child: ListTileTheme.merge(
                  iconColor: _iconColor.value,
                  textColor: _headerColor.value,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      contentPadding: widget.contentPadding,
                      leading: widget.leading,
                      title: widget.title,
                      subtitle: widget.subtitle,
                      trailing: widget.trailing ??
                          RotationTransition(
                            turns: _iconTurns,
                            child: const Icon(Icons.expand_more),
                          ),
                    ),
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _headerColorTween
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _materialColorTween
      ..begin = widget.baseColor ?? theme.canvasColor
      ..end = widget.expandedColor ?? theme.cardColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}

class _CheckCheckMedicalFileState extends State<CheckMedicalFile> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    print(HomeScreen.homePatient.id);
    HomeScreen.isCheckingMedicalFile = false;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new Column(
          children: <Widget>[
            Text(
                HomeScreen.homePatient.name.capitalize() +
                    " " +
                    HomeScreen.homePatient.lastName.capitalize() +
                    "'s Medical File",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontFamily: 'Poppins')),
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
                      SizedBox(height: 5.0),
                      Expanded(
                          child: FutureBuilder(
                        future: httpService
                            .getAnalaysisResults(HomeScreen.homePatient.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<AnalysisResult>> snapshot) {
                          if (snapshot.hasData) {
                            List<AnalysisResult> analysisRes = snapshot.data;
                            return AnimatedList(
                                key: _key,
                                initialItemCount: analysisRes.length,
                                itemBuilder: (BuildContext context, int index,
                                    Animation animation) {
                                  AnalysisResult analysisResult =
                                      analysisRes[index];
                                  return _buildAnalysisList(context,
                                      analysisResult, analysisRes, animation);
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      )),
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
