import 'package:flutter/material.dart';
//import 'package:loading/indicator/ball_pulse_indicator.dart';
//import 'package:loading/loading.dart';
import 'package:beer/widgets/navigation.dart';
import 'package:beer/widgets/login.dart';
import 'package:beer/widgets/colors/colors.dart';

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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  backgroundColor: appBackgroundColor,
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          onPressed: () => {print('Go to profile')},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: appColor,
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          onPressed: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                //login logic
                                builder: (context) => Login(),
                              ),
                            )
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
          ),
        ],
      ),
      body: NavigationBar(),
    );
  }
}
