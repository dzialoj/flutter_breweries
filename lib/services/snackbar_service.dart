import 'package:flutter/material.dart';

class SnackbarService extends StatefulWidget {
  SnackbarService({Key key, this.content, this.isError}) : super(key: key);
  final String content;
  final bool isError;
  @override
  SnackbarServiceState createState() => SnackbarServiceState();
}

class SnackbarServiceState extends State<SnackbarService> {
  showSuccessSnackbar(String content) {
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

  showErrorSnackbar(String content) {
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.isError
            ? showErrorSnackbar(widget.content)
            : showSuccessSnackbar(widget.content));
  }
}
