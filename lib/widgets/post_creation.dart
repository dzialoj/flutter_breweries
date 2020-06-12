import 'dart:convert';

import 'package:beer/interfaces/Post.dart';
import 'package:beer/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'colors/colors.dart';

class PostCreation extends StatefulWidget {
  PostCreation({Key key}) : super(key: key);
  @override
  PostCreationState createState() => PostCreationState();
}

class PostCreationState extends State<PostCreation> {
  Geolocator geolocator = new Geolocator();
  var userData;
  var currentLatitudeLongitude;
  var title;
  var description;
  
  _submit() async {
    Post newPost = new Post(
        title,
        userData['uid'],
        userData['username'],
        userData['avatar'],
        currentLatitudeLongitude.latitude,
        currentLatitudeLongitude.longitude,
        description,
        new DateTime.now());
    await createNewPost(newPost).then((response) => {
      print(response.body)
    }).catchError((e) => {
      print(e)
    });
  }

  Future _initUserData() async {
    //lat,long,userdata(pic/username)
    try {
      var response = await getCurrentUserFromDb();
      setState(() {
        userData = json.decode(response.body);
      });
      print(userData);
    } catch (e) {
      print(e);
    }
  }

  _getCurrentPosition() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentLatitudeLongitude = position;
      });
      print(currentLatitudeLongitude);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserData();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text('Whatcha Drinkin\'?'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: appBackgroundColor,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                child: TextField(
                  textAlign: TextAlign.left,
                  style: TextStyle(color: appColor),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: appColor),
                  ),
                  onChanged: (val) {
                    title = val;
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  maxLines: 5,
                  maxLengthEnforced: true,
                  style: TextStyle(color: appColor),
                  decoration: InputDecoration(
                      fillColor: Colors.blue,
                      hintStyle: TextStyle(color: appColor),
                      hintText: 'Description'),
                  onChanged: (val) {
                    description = val;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                  color: appColor,
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
