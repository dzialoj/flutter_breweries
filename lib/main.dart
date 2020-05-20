import 'package:flutter/material.dart';
//widgets
import 'package:beer/widgets/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:beer/widgets/colors/colors.dart';


void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: appBackgroundColor
      ),
      home: Login(),
    );
  }
}
