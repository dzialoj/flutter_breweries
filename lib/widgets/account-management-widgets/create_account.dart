import 'package:beer/widgets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future _selectUserAvatar() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = image;
    });
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
              padding: EdgeInsets.only(top: 20),
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        _image != null ? FileImage(_image) : null,
                    child: _image == null
                        ? IconButton(
                            icon: Icon(Icons.add_a_photo), onPressed: () => { _selectUserAvatar() })
                        : null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
