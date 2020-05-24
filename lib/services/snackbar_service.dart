import 'package:flutter/material.dart';

showSuccessSnackbar(String content, context) {
  Scaffold.of(context).showSnackBar(
    new SnackBar(
      content: new Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ),
  );
}

showErrorSnackbar(String content, context) {
  Scaffold.of(context).showSnackBar(
    new SnackBar(
      content: new Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ),
  );
}
