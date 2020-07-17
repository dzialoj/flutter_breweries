import 'dart:convert';

import 'package:beer/services/firebase_auth_service.dart';
import 'package:beer/services/firebase_storage_service.dart';
import 'package:flutter/material.dart';
//import 'package:loading/indicator/ball_pulse_indicator.dart';
//import 'package:loading/loading.dart';
import 'package:beer/widgets/navigation.dart';
import 'package:beer/widgets/login.dart';
import 'package:beer/widgets/colors/colors.dart';
import 'package:loading/loading.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Map<String, String> currentUserData = {'username': '', 'photoUrl': ''};
  bool loading = false;

  _logout() {
    signOut();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return Login();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  getCurrentUser() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await getCurrentUserFirebaseUser();
      var avatar = await getUserProfilePicture(response.uid);
      setState(() {
        currentUserData['username'] = response.displayName;
        currentUserData['avatar'] = avatar;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCurrentUser();
  }

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
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
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
                          onPressed: () => {getCurrentUser()},
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
                          onPressed: () => {_logout()},
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: loading == false
                ? Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: currentUserData['username'] != null
                              ? Text(currentUserData['username'])
                              : Text('username'),
                        ),
                        CircleAvatar(
                          backgroundImage: currentUserData['avatar'] != null
                              ? NetworkImage(currentUserData['avatar'])
                              : NetworkImage('https://i.pravatar.cc/300'),
                        ),
                      ],
                    ),
                  )
                : Loading(color: appColor, size: 30),
          ),
        ],
      ),
      body: NavigationBar(),
    );
  }
}
