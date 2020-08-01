import 'package:beer/widgets/home.dart';
import 'package:flutter/material.dart';
//widgets
import 'package:beer/widgets/login.dart';
import 'package:beer/services/firebase_auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:beer/widgets/colors/colors.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  isLoggedIn() {
    var user = getCurrentUserFirebaseUser();
    if (user != null) {
      return Home(
        title: 'Home',
      );
    }
    return Login();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew',
      theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: appColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: appBackgroundColor),
      home: isLoggedIn(),
    );
  }
}
