import 'package:covid19/burger_menu.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(new Covid());

class Covid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Covid",
      theme: ThemeData(),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 15,
      backgroundColor: Colors.white,
      image: Image.asset("assets/load.gif"),
      loaderColor: Colors.red,
      photoSize: 150.0,
      navigateAfterSeconds: burger_menu(),
    );
  }

}
