import 'dart:convert';
import 'dart:io';

import 'package:beer/widgets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beer/services/http_service.dart';

class CreateAccount extends StatefulWidget {
  @override
  CreateAccountState createState() => CreateAccountState();
}

// form to create profile
// Form validation:
// need to check for duplicate usernames/emails
class CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  var _image;
  String _username = '';
  String _email = '';
  String _password = '';
  String _verifyPass = ''; //fix this validation rule

  var imageForDisplay;
  Future _selectUserAvatar() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10,
        maxWidth: 400,
        maxHeight: 400);
    imageForDisplay = image;
    // List<int> imageBytes = image.readAsBytesSync();
    // var base64Image = base64Encode(imageBytes);
    // print(base64Image);
    String base64Image = base64Encode(image.readAsBytesSync());
    setState(() {
      _image = base64Image;
    });
  }

  Future submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    var formData = {
      "username": _username,
      "password": _password,
      "email": _email,
      "avatar": _image,
    };
    createAccount(formData)
        .then((res) => {print(res.body)})
        .catchError((e) => {print(e)});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 80, bottom: 20),
              child: Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          _image != null ? FileImage(imageForDisplay) : null,
                      child: _image == null
                          ? IconButton(
                              icon: Icon(Icons.add_a_photo),
                              onPressed: () => {_selectUserAvatar()},
                            )
                          : null),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onSaved: (val) {
                        _username = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter a username.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onSaved: (val) {
                        _email = val;
                      },
                      validator: (val) {
                        var emailRegex = RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(val);
                        if (!emailRegex || val.isEmpty) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onSaved: (val) {
                        _password = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Verify Password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onSaved: (val) {
                        _verifyPass = val;
                      },
                      validator: (val) {
                        if (val != _password) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: RaisedButton(
                color: appColor,
                padding: EdgeInsets.only(left: 25, right: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: Text('Create'),
                onPressed: () => {submitForm()},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
