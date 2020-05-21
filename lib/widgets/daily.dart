import 'package:beer/widgets/colors/colors.dart';
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

//could be generated off followers and random users in the area.
//only local posts / follower posts
  _generateFeedCards() {
    List<Widget> cards = [];

    for (var i = 0; i < 10; i++) {
      var newCard = Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: appColor,
          elevation: 5.0,
          semanticContainer: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Username2020',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Image(
                fit: BoxFit.fitHeight,
                image: NetworkImage('https://picsum.photos/400/200'),
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    color: Colors.white,
                    onPressed: () => {print('dddd')},
                  )
                ],
              )
            ],
          ),
          borderOnForeground: true,
        ),
      );

      cards.add(newCard);
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Center(
      child: ListView(shrinkWrap: true, children: _generateFeedCards()),
    );
  }
}
