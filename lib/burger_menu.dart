import 'package:covid19/list_countries_page.dart';
import 'package:covid19/recomendation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class burger_menu extends StatefulWidget {
  @override
  burger_menuState createState() => burger_menuState();
}

class burger_menuState extends State<burger_menu> {
  ListCountriesState listCountriesState = ListCountriesState();

  Map data;
  List globalData;
  int totalConfirmed;
  int totalDeaths;
  int totalRecovered;
  int newDeaths;


  Future getData() async {
    http.Response response = await http.get("https://api.covid19api.com/summary");
    data = json.decode(response.body);
    setState(() {
      totalConfirmed = data['Global']['TotalConfirmed'];
      totalDeaths = data['Global']['TotalDeaths'];
      totalRecovered = data['Global']['TotalRecovered'];
      newDeaths = data['Global']['NewDeaths'];

    });
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 250.0,
              ),
              ListTile(
                leading: Icon(Icons.toll),
                title: Text(
                  "List Countries",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => list_countries_page()))
                      .whenComplete(
                          () => {listCountriesState.loadListCountries()});
                },
              ),
              ListTile(
                leading: Icon(Icons.toll),
                title: Text(
                  "Recomendation",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => InfoScreen()));},
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Covid"),
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Container(
    padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
    width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.redAccent,
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(50),
    bottomRight: Radius.circular(50),
    ),
    ),
    child: Wrap(
    runSpacing: 20,
    spacing: 20,
    children: <Widget>[
    InfoCard(
    title: "Total Confirmed",
    iconColor: Color(0xFFFF8C00),
    effectedNum: totalConfirmed.toString(),
    press: () {},
    ),
    InfoCard(
    title: "Total Deaths",
    iconColor: Color(0xFFFF2D55),
    effectedNum: totalDeaths.toString(),
    press: () {},
    ),
    InfoCard(
    title: "Total Recovered",
    iconColor: Color(0xFF50E3C2),
    effectedNum: totalRecovered.toString(),
    press: () {},
    ),
    InfoCard(
    title: "New Deaths",
    iconColor: Color(0xFF5856D6),
    effectedNum: newDeaths.toString(),
    press: () {},
    ),
    ],
    ),
    ),
    SizedBox(height: 20),
    Container(
    decoration: new BoxDecoration(
    image: new DecorationImage(
    image: new AssetImage("assets/main_corona.jpg"),
    fit: BoxFit.cover,
    ),
    ),
    height: 250.0,
    ),
    ],
    ))
    );
  }
}




  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 999 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.black),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          Positioned(
          ),
        ],
      ),
    );
  }


AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.redAccent,
    elevation: 0,
    leading: IconButton(
      onPressed: () {},
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
      ),
    ],
  );
}



class InfoCard extends StatelessWidget {
  final String title;
  final String effectedNum;
  final Color iconColor;
  final Function press;
  const InfoCard({
    Key key,
    this.title,
    this.effectedNum,
    this.iconColor,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: press,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            // Here constraints.maxWidth provide us the available width for the widget
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        // wrapped within an expanded widget to allow for small density device
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: iconColor.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),

                            ),
                          ),
                        SizedBox(width: 5),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.red),
                              children: [
                                TextSpan(
                                  text: "$effectedNum \n",
                                  style:
                                  Theme.of(context).textTheme.headline6.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "People",
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: LineReportChart(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LineReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Colors.redAccent],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports() {
    return [
      FlSpot(0, .5),
      FlSpot(1, 1.5),
      FlSpot(2, .5),
      FlSpot(3, .7),
      FlSpot(4, .2),
      FlSpot(5, 2),
      FlSpot(6, 1.5),
      FlSpot(7, 1.7),
      FlSpot(8, 1),
      FlSpot(9, 2.8),
      FlSpot(10, 2.5),
      FlSpot(11, 2.65),
    ];
  }
}