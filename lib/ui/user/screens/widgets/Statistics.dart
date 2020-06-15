import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_world/ui/user/config/config.dart';
import 'package:hello_world/ui/user/models/stat.dart';
import 'package:http/http.dart';
import '../../MyHomePage.dart';
import '../_HomePrescription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'dart:async';

class StatPage extends StatefulWidget {
  final Widget child;

  StatPage({Key key, this.child}) : super(key: key);

  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
        new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  Future<String> getUsers() async {
    final String northeast = API_URL + "/stat/patients";
    Response res = await get(northeast);
    return res.body;
  }

  Future<String> getPharms() async {
    final String northeast = API_URL + "/stat/pharmacies";
    Response res = await get(northeast);
    return res.body;
  }

  Future<String> getPending() async {
    final String northeast = API_URL + "/stat/pending";
    Response res = await get(northeast);
    return res.body;
  }

  Future<String> getClosed() async {
    final String northeast = API_URL + "/stat/closed";
    Response res = await get(northeast);
    return res.body;
  }

  Future<String> getAll() async {
    final String northeast = API_URL + "/stat/all";
    Response res = await get(northeast);
    return res.body;
  }

  Future<List<Stat>> getcity() async {
    final String northeast = API_URL + "/stat/city";
    Response res = await get(northeast);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Stat> posts = body
          .map(
            (dynamic item) => Stat.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  Future<List<Stat>> getDrug() async {
    final String northeast = API_URL + "/stat/drug";
    Response res = await get(northeast);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Stat> posts = body
          .map(
            (dynamic item) => Stat.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }

  getByRegion() async {
    final String northeast = API_URL + "/stat/region/northeast";
    Response resNE = await get(northeast);
    final String northwest = API_URL + "/stat/region/northwest";
    Response resNW = await get(northwest);
    final String southeast = API_URL + "/stat/region/Southeast";
    Response resSE = await get(southeast);
    final String southwest = API_URL + "/stat/region/Southwest";
    Response resSW = await get(southwest);
    final String centereast = API_URL + "/stat/region/Centereast";
    Response resCE = await get(centereast);
    final String centerwest = API_URL + "/stat/region/Centerwest";
    Response resCW = await get(centerwest);

    double total = double.parse(resNE.body) +
        double.parse(resSE.body) +
        double.parse(resNW.body) +
        double.parse(resSW.body) +
        double.parse(resCE.body) +
        double.parse(resCW.body);

    var piedata = [
      new Task(
          'North East',
          ((double.parse(resNE.body) / total) * 100).roundToDouble(),
          Color(0xff3366cc)),
      new Task(
          'North West',
          ((double.parse(resNW.body) / total) * 100).roundToDouble(),
          Color(0xff990099)),
      new Task(
          'East Center ',
          ((double.parse(resCE.body) / total) * 100).roundToDouble(),
          Color(0xff109618)),
      new Task(
          'West Center',
          ((double.parse(resCW.body) / total) * 100).roundToDouble(),
          Color(0xfffdbe19)),
      new Task(
          'South East',
          ((double.parse(resSE.body) / total) * 100).roundToDouble(),
          Colors.cyan),
      new Task(
          'South West',
          ((double.parse(resSW.body) / total) * 100).roundToDouble(),
          Color(0xffdc3912)),
    ];
    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
    return _seriesPieData;
  }

  Material myTextItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myCircularItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AnimatedCircularChart(
                      size: const Size(100.0, 100.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material mychart1Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material mychart2Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data1,
                      fillMode: FillMode.below,
                      fillGradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber[800], Colors.amber[200]],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getByAge() async {
    final String northeast = API_URL + "/stat/age/0-11";
    Response res1 = await get(northeast);
    final String northwest = API_URL + "/stat/age/12-19";
    Response res2 = await get(northwest);
    final String southeast = API_URL + "/stat/age/20-59";
    Response res3 = await get(southeast);
    final String southwest = API_URL + "/stat/age/60";
    Response res4 = await get(southwest);

    double total = double.parse(res1.body) +
        double.parse(res2.body) +
        double.parse(res3.body) +
        double.parse(res4.body);

    var data2 = [
      new Pollution(
          1985,
          '',
          ((double.parse(res1.body) / total) * 100).roundToDouble(),
          Colors.yellow[200]),
    ];
    var data3 = [
      new Pollution(
          1985,
          '',
          ((double.parse(res2.body) / total) * 100).roundToDouble(),
          Colors.deepOrange[300]),
    ];
    var data4 = [
      new Pollution(
          1985,
          '',
          ((double.parse(res3.body) / total) * 100).roundToDouble(),
          Colors.blue),
    ];
    var data5 = [
      new Pollution(
          1985,
          '',
          ((double.parse(res4.body) / total) * 100).roundToDouble(),
          Color(0xff3366cc)),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
        id: '0-11',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
        id: '12-19',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
        id: '20-59',
        data: data4,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
        id: '60 and over',
        data: data5,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    getByAge();
    getByRegion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatPage()),
                  );
                },
                child: Icon(
                  Icons.refresh, // add custom icons also
                  size: 35,
                ),
              ),
              Text("   ")
            ],
            leading: GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.clear();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()),
                    (Route<dynamic> route) => false);
              },
              child: Icon(
                FontAwesomeIcons.windowClose, // add custom icons also
              ),
            ),

            backgroundColor: Color.fromRGBO(110, 120, 247, 1),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.home)),
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
              ],
            ),
            title: Text('Doctian Statistics'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xffE5E5E5),
                  child: StaggeredGridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    children: <Widget>[
                      FutureBuilder(
                        future: getDrug(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Stat>> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: myTextItems(
                                  "Most requested drug\n",
                                  snapshot.data.single.id+"\n"+
                                  snapshot.data.single.count.toString() +
                                      " requests"),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder(
                        future: getAll(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: myTextItems(
                                  "Drug requests", snapshot.data),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder(
                        future: getPending(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: myTextItems(
                                  "Pending requests", snapshot.data),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder(
                        future: getClosed(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: myTextItems(
                                  "Closed requests",
                                  snapshot.data,
                                ));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder(
                        future: getcity(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Stat>> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: myTextItems(
                                  "Most requested City\n",
                                  snapshot.data.single.id+"\n"+
                                  snapshot.data.single.count.toString() +
                                      " requests"),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(4, 250.0),
                      StaggeredTile.extent(2, 250.0),
                      StaggeredTile.extent(2, 120.0),
                      StaggeredTile.extent(2, 120.0),
                      StaggeredTile.extent(4, 250.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Percentage of drug requests by age\n                   ',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            behaviors: [
                              new charts.SeriesLegend(
                                outsideJustification:
                                    charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 1,
                                cellPadding: new EdgeInsets.only(
                                    right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                    color: charts
                                        .MaterialPalette.purple.shadeDefault,
                                    fontFamily: 'Georgia',
                                    fontSize: 11),
                              )
                            ],
                            animationDuration: Duration(seconds: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Percentage of drug requests by region\n',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 1),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                      charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 2,
                                  cellPadding: new EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts
                                          .MaterialPalette.purple.shadeDefault,
                                      fontFamily: 'Georgia',
                                      fontSize: 11),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  double quantity;
  Color colorval;

  Pollution(this.year, this.place, this.quantity, this.colorval);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
