import 'dart:convert';
import 'package:covid19/open_dialog_page.dart';
import 'package:flag/flag.dart';
import 'package:covid19/total_country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SearchFuture.dart';

class list_countries_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListCountriesState();
  }
}

List<total_country> data = [];

class ListCountriesState extends State<list_countries_page> {


 void loadListCountries() async {
    final response = await http.get("https://api.covid19api.com/summary");
    if (response.statusCode == 200) {
      var decodeData =
      (json.decode(response.body) as Map)['Countries'] as List<dynamic>;
      var ListCountriesData = List<total_country>();
      decodeData.forEach((dynamic val) {
        var record = total_country(
            country: val['Country'],
            countryCode: val['CountryCode'],
            totalConfirmed: val['TotalConfirmed'].toString());
        ListCountriesData.add(record);
          data = ListCountriesData;
          //data.sort((a, b) => a.totalConfirmed.compareTo(b.totalConfirmed));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        title: Text("Flutter App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchFuture((query) {}));
            },
          ),
        ],
      ),
      body: Container(
          child: ListView(
        children: _buildList(),
      )),
    );
  }



  List<Widget> _buildList() {
    return data
        .map((total_country totalCountry) => ListTile(
              title: Text(
                totalCountry.country,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                totalCountry.countryCode,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              leading: Flag(
                totalCountry.countryCode,
                height: 20,
                width: 25,
                fit: BoxFit.fill,
              ),
              trailing: Text(
                totalCountry.totalConfirmed.toString(),
                style: TextStyle(fontSize: 15,  color: Colors.redAccent),
              ),
          onTap:() => Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, _,__) => open_dialog_page()
          )),
            ))
        .toList();
  }
}


