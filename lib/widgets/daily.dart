import 'package:flutter/material.dart';

class Daily extends StatefulWidget {
  Daily({Key key}) : super(key: key);
  @override
  DailyState createState() => DailyState();
}

class DailyState extends State<Daily> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              elevation: 5.0,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.pink,
              child: Column(
                children: <Widget>[
                  Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage('https://picsum.photos/400/300'),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () => {print('dddd')},
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_down),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () => {print('dddd')},
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () => {print('dddd')},
                      )
                    ],
                  )
                ],
              ),
              borderOnForeground: true,
            ),
          ),
        ],
      ),
    );
  }
}
