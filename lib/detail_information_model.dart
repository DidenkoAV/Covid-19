import 'package:flutter/cupertino.dart';

class detail_information_model {
  String Country;
  int NewConfirmed;
  int TotalConfirmed;
  int NewDeaths;
  int TotalDeaths;
  int NewRecovered;
  int TotalRecovered;

  detail_information_model({
    this.Country,
    this.NewConfirmed,
    this.TotalConfirmed,
    this.NewDeaths,
    this.TotalDeaths,
    this.NewRecovered,
    this.TotalRecovered
  });

  detail_information_model.fromJson(Map<String, dynamic> json) {
    Country = json['Country'];
    NewConfirmed = json['NewConfirmed'];
    TotalConfirmed = json['TotalConfirmed'];
    NewDeaths = json['NewDeaths'];
    TotalDeaths = json['TotalDeaths'];
    NewRecovered = json['NewRecovered'];
    TotalRecovered = json['TotalRecovered'];
  }

}


