import 'package:flutter/material.dart';
//import 'package:loading/indicator/ball_pulse_indicator.dart';
//import 'package:loading/loading.dart';
import 'package:beer/widgets/navigation.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 5,
      ),
      body: NavigationBar(),
    );
  }
}
